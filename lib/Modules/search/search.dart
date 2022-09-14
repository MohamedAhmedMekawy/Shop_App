import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/products/product_details.dart';
import 'package:shopping_app/Modules/search/cubit/cubit.dart';
import 'package:shopping_app/Modules/search/cubit/states.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/models/search_model.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value){
                          if(value.isEmpty){
                            return 'Please Enter Your Search';
                          }
                        },
                        prefix: Icons.search,
                        text: 'Search',
                    onSubmit: (String? text){
                          SearchCubit.get(context).searchModel(text);
                    }
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 26,
                    ),
                    if(state is SearchSuccessState)
              Expanded(
                child: ListView.separated(
                        itemBuilder: (context, index) => buildFavItem(SearchCubit.get(context).search!.data!.data![index], context),
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
              ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildFavItem(model, context, {bool isOldPrice = true}) => InkWell(
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
                  model.image!
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
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.2),),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),

                      Spacer(),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor:ShopLayoutCubit.get(context).favorites[model.id]! ? Colors.blue : Colors.grey,
                        child: IconButton(
                          onPressed:() {
                            ShopLayoutCubit.get(context).changeFavorite(model.id!);
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
