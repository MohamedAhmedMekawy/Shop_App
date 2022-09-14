import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shopping_app/Modules/carts/carts_screen.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/models/product_details.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class ProductDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var mode = ShopLayoutCubit.get(context).productDetailsModel!.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'Details'
              ),
              actions: [
                Stack(
                  alignment: Alignment.topLeft,
                   children: [
                     IconButton(onPressed: (){
                     }, icon: Icon(Icons.shopping_cart_outlined,
                     size: 40),
                     color: Colors.blue,),
                     CircleAvatar(
                       radius: 10.0,
                       backgroundColor: Colors.red.withOpacity(0.8),
                       child: Text(
                         ShopLayoutCubit.get(context).cartModel!.data!.cartItems!.length.toString()
                       ),
                     )

                   ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor:
                    ShopLayoutCubit.get(context).favorites[mode!.id]!
                        ? Colors.blue
                        : Colors.grey,
                    child: IconButton(
                      onPressed: () {
                        ShopLayoutCubit.get(context).changeFavorite(mode.id!);
                      },
                      icon: Icon(Icons.favorite_border),

                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! ShopLayoutLoadingGetProductsDetailsStates,
              builder: (context) => buildProductDet(ShopLayoutCubit.get(context).productDetailsModel!, context),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }

  PageController imageContriller = PageController();
  Widget buildProductDet(ProductDetailsModel? model, context) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: PageView.builder(
                controller: imageContriller,
                itemBuilder: (context, index) => CachedNetworkImage(
                  imageUrl: model!.data!.images![index],
                ),
                itemCount: model!.data!.images!.length,
              ),
            ),
            SmoothPageIndicator(
              controller: imageContriller,
              count: model.data!.images!.length,
              effect: WormEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blue,
                  dotWidth: 10,
                  dotHeight: 10,
                  spacing: 7
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300]!.withOpacity(.8),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).size.height / 12,
                ),
                child: Column(
                  children: [
                    Text(
                      model.data!.name!,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.data!.price}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        if(model.data!.discount != 0)
                          Text(
                            '${model.data!.oldPrice}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 7,
                                decoration: TextDecoration.lineThrough
                            ),

                          ),
                        SizedBox(
                          width: 6,
                        ),
                        if(model.data!.discount != 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text(
                              '${model.data!.discount}% Off',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                              ),
                            ),
                          ),

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ReadMoreText(
                      model.data!.description!,
                      readMoreText: 'read more',
                      readLessText: 'read less',
                      numLines: 2,

                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
  Padding(
  padding: const EdgeInsets.only(
  right: 20.0,
  left: 20,
  ),
  child: Container(
  decoration: BoxDecoration(
  color: Colors.grey[350]!.withOpacity(1),
  borderRadius: BorderRadius.only(

  topLeft: Radius.circular(10)
  )
  ),

  child: Row(
  children: [
  Text(
  '${model.data!.price}',
  style: TextStyle(
  color: Colors.blue,
  fontSize: 18
  ),
  ),
    if (model.data!.discount != 0)
  Text(
  '${model.data!.oldPrice}',
  style: TextStyle(
  color: Colors.grey,
  fontSize: 10,
  decoration: TextDecoration.lineThrough
  ),
  ),
  Expanded(
  child: Container(
  width: double.infinity,
  decoration: BoxDecoration(
  color:ShopLayoutCubit.get(context).carts[model.data!.id]! ? Colors.blue : Colors.grey,
  borderRadius: BorderRadius.only(
  bottomLeft: Radius.circular(10),
  topRight: Radius.circular(10),
  )
  ),
  padding: EdgeInsets.symmetric(
  vertical: 5,
  horizontal: 5
  ),
  child: MaterialButton(
  onPressed: (){
  ShopLayoutCubit.get(context).changeCart(model.data!.id!);
  },
  child: Text(
  'Add Cart'
  ),
  )
  ),
  ),
    ],

  )
  )
  ),
  ]
  );

}
