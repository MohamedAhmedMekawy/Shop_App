import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/categories/categories_details.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder:  (context, index) => buildCat(ShopLayoutCubit.get(context).categoriesModel!.data!.data[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 1,
                color: Colors.grey,
                width: double.infinity,
              ),
            ),
            itemCount: ShopLayoutCubit.get(context).categoriesModel!.data!.data.length);
      },
    
    );
  }
  Widget buildCat(CatDataModel model, context) => InkWell(
  onTap: (){
  ShopLayoutCubit.get(context).getCategoriesDetails(model.id!);
  navigateTo(context, CategoriesDetails());
  },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 100,
        child: Row(
          children: [
        CachedNetworkImage(
        imageUrl: model.image!,
          errorWidget: (context, url, error) => Icon(Icons.error),
          height: 120,
          width: 120,
          fit: BoxFit.cover,),

            SizedBox(
              width: 20,
            ),
            Text(
              model.name!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Spacer(),
            Expanded(
              child: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.arrow_forward_ios)),
            )
          ],
        ),
      ),
    ),
  );
}
