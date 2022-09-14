import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/products/product_details.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/models/categories_details.dart';
import 'package:shopping_app/models/home_model.dart';

class CategoriesDetails extends StatelessWidget {
  const CategoriesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopLayoutCubit.get(context).categoryDetailModel!.data;
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: state is! ShopLayoutLoadingGetCategoriesDetailsStates,
            builder: (context) =>  Container(
              color: Colors.grey[300],
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.89,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                    model!.catData.length, (index) => productModel(model.catData[index], context)),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );

  }
  Widget productModel(CatData? model,context) =>Container(
      color: Colors.white,
      padding: EdgeInsets.all(5.0),
      child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    InkWell(
                      onTap: () {
                        ShopLayoutCubit.get(context).getProductDetails(model!.id!);
                        navigateTo(context, ProductDetails());
                      },
                      child: CachedNetworkImage(
                        imageUrl: model!.image!,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: double.infinity,
                        height: 200.0,
                      ),
                    ),
                    CircleAvatar(
                      radius: 18.0,
                      backgroundColor:
                      ShopLayoutCubit.get(context).favorites[model.id]!
                          ? Colors.blue
                          : Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          ShopLayoutCubit.get(context).changeFavorite(model.id!);
                          print(model.id.toString());
                        },
                        icon: Icon(Icons.favorite_border),
                        iconSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 8.0, color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
            Spacer(),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                      children: [
                        Text(
                          '${model.price.round()}LE',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.blue),
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice.round()}',
                            style: TextStyle(
                              fontSize: 6.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        Expanded(



                          child: IconButton(onPressed: (){

                            ShopLayoutCubit.get(context).changeCart(model.id!);

                            print(model.id);

                          },



                              icon: CircleAvatar(

                                radius: 22,

                                backgroundColor:ShopLayoutCubit.get(context).carts[model.id]! ? Colors.blue : Colors.grey,

                                child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 26,),)),



                        ),
                      ]
                  )
                ]
            )
          ]
      )

  );

}
