import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/products/product_details.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/models/favorite_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLayoutLoadingGetFavoriteStates,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavItem(ShopLayoutCubit.get(context).favoriteModel!.data!.data![index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                height: 1,
                  color: Colors.grey,
                width: double.infinity,
              ),
            ),
            itemCount: ShopLayoutCubit.get(context).favoriteModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildFavItem(FavoriteData model, context) =>InkWell(
    onTap: () {
      ShopLayoutCubit.get(context).getProductDetails(model.id!);
      navigateTo(
          context,
          ProductDetails());
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(
                    model.product!.image!
                ),
                width: 120,
                height: 120,),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.product!.discount != 0)
                      Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            'DISCOUNT',
                            style: TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      model.product!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.2),),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product!.price}',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        if(model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                        Spacer(),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor:ShopLayoutCubit.get(context).favorites[model.product!.id]! ? Colors.blue : Colors.grey,
                          child: IconButton(
                            onPressed:() {
                              ShopLayoutCubit.get(context).changeFavorite(model.product!.id!);
                            },
                            icon: Icon(Icons.favorite_border,size: 14,),
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )

            ],
          ),

      ),
    ),
  );
}
