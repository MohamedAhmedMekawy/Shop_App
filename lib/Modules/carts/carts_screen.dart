import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/address/AddAddress.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/models/carts_model.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if(state is ShopLayoutSuccessAddOrdersStates){
          if(state.addOrderModel.status){
            showToast(text: state.addOrderModel.message, state: ToastState.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomAppBar(

            elevation: 12,
            child: Container(
           height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Totle Price: ',
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Text(
                          '${cubit.cartModel!.data!.total}EGP',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: (){
                      cubit.addOrder();
                          navigateTo(context, AddOrUpDateAddress(isEdit: false));

                      },
                      child: Text(
                        'CheckOut', style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! ShopLayoutLoadingGetCartsStates,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildFavItem(ShopLayoutCubit.get(context).cartModel!.data!.cartItems![index], context, index),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  height: 1,
                  color: Colors.grey,
                  width: double.infinity,
                ),
              ),
              itemCount: ShopLayoutCubit.get(context).cartModel!.data!.cartItems!.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
  Widget buildFavItem(CartItems model, context, index) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 160,
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
              children: [
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
                        '${model.product!.oldPrice!.round()}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    Spacer(),
                    if (model.product!.discount != 0)
                      Container(
                        color: Colors.green,
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RawMaterialButton(
                      elevation: 2,
                      shape: CircleBorder(),
                      fillColor: Colors.blue,
                      onPressed: (){
                        ShopLayoutCubit.get(context).plusQuantity(ShopLayoutCubit.get(context).cartModel!, index);
                        ShopLayoutCubit.get(context).updateCartData(
                            id: ShopLayoutCubit.get(context).cartModel!.data!.cartItems![index].id.toString(),
                        quantity: ShopLayoutCubit.get(context).quantity);
                        print(index.toString());

                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      size: 20,),
                      constraints: BoxConstraints.tightFor(
                        height: 30,
                        width: 30
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(ShopLayoutCubit.get(context)
                        .cartModel!
                        .data!
                        .cartItems![index]
                        .quantity
                        .toString(),
              style: TextStyle(fontSize: 23.0),

                    ),
                    SizedBox(
                      width: 3,
                    ),
                    RawMaterialButton(
                      elevation: 2,
                      shape: CircleBorder(),
                      fillColor: Colors.blue,
                      onPressed: (){
                        ShopLayoutCubit.get(context).minusQuantity(ShopLayoutCubit.get(context).cartModel!, index);
                        ShopLayoutCubit.get(context).updateCartData(
                            id: ShopLayoutCubit.get(context).cartModel!.data!.cartItems![index].id.toString(),
                          quantity: ShopLayoutCubit.get(context).quantity
                        );
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 20,),
                      constraints: BoxConstraints.tightFor(
                          height: 30,
                          width: 30
                      ),
                    ),

                    Expanded(

                      child: IconButton(onPressed: (){
                        ShopLayoutCubit.get(context).changeCart(model.product!.id!);
                        print(model.id);
                      },

                          icon: CircleAvatar(
                            radius: 22,
                            backgroundColor:ShopLayoutCubit.get(context).carts[model.product!.id]! ? Colors.red : Colors.grey,
                            child: Icon(Icons.delete,color: Colors.white,size: 26,),)),

                    ),

                  ],
                )
              ],
            ),
          )

        ],
      ),
    ),
  );
}
