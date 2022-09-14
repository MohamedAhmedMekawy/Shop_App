import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/Modules/categories/categories_details.dart';
import 'package:shopping_app/Modules/products/product_details.dart';

import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/models/categories_model.dart';
import 'package:shopping_app/models/home_model.dart';
import 'package:shopping_app/models/product_details.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if(state is ShopLayoutSuccessChangeFavStates && state is ShopLayoutSuccessChangeCartStates ){
          if(!state.changeFavorites.status!){
            showToast(
                text: state.changeFavorites.message!,
                state: ToastState.ERROR);
          }
        }
        },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).homeModel != null && ShopLayoutCubit.get(context).categoriesModel != null,
          builder: (context) => productBuilder(ShopLayoutCubit.get(context).homeModel, ShopLayoutCubit.get(context).categoriesModel!, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget productBuilder(HomeModel? model, CategoriesModel categoriesModel, context) =>  Padding(
  padding: const EdgeInsets.all(20.0),
  child:SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)
              ),
              child: MaterialButton(
                onPressed: (){
                },
                child: Row(
                  children: [
                    Text(
                        'search'
                    ),
                    Spacer(),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CarouselSlider(
                items: model!.data!.banners.map((e) =>
                  CachedNetworkImage(
                    imageUrl: '${e.image}',
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ).toList(),

                options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    reverse: false,
                    autoPlay: true,
                    viewportFraction: 1,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal
                )
    ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Categories' ,
              style: GoogleFonts.abhayaLibre(
                  fontWeight: FontWeight.bold,
                  fontSize: 28
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              height: 120,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => categoriesItems(categoriesModel.data!.data[index], context),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 6,
                  ),
                  itemCount: categoriesModel.data!.data.length,
              )
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Products' ,
              style: GoogleFonts.abhayaLibre(
                  fontWeight: FontWeight.bold,
                  fontSize: 28
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                  crossAxisCount: 2,
                childAspectRatio: 1 / 2.12,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                model.data!.products.length, (index) => productModel(model.data!.products[index], context)),
              ),
            )
          ],
        ),
      ],
    ),
  )
  );
Widget productModel(ProductModel model,context) => Container(
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
              ShopLayoutCubit.get(context).getProductDetails(model.id!);
              navigateTo(context, ProductDetails());
            },
            child: CachedNetworkImage(
              imageUrl: model.image!,
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
      fontWeight: FontWeight.w800,
      color: Colors.blue),
),
        if (model.discount != 0)

          Text(
  '${model.old_price.round()}',
  style: TextStyle(
  fontSize: 12.0,
  color: Colors.grey,
  decoration: TextDecoration.lineThrough,
  ),
  ),
       SizedBox(
         width: 5,
       ),
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

Widget categoriesItems(CatDataModel model, context) => InkWell(
  onTap: (){
    ShopLayoutCubit.get(context).getCategoriesDetails(model.id!);
    navigateTo(context, CategoriesDetails());
  },
  child:   Container(

    height: 140,

    width: 100,

    child: Column(

      children: [

        CircleAvatar(

        backgroundImage: NetworkImage(model.image!),

        radius: 40,

      ),

        SizedBox(

          height: 7,

        ),

        Text(

            model.name!,

          maxLines: 1,

          overflow: TextOverflow.ellipsis,

        ),

      ],

    ),

  ),
);
}
