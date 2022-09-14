import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/models/getorder_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
    listener: (context, state) {},
      builder: (context, state) {
      var model = ShopLayoutCubit.get(context).getOrdersModel!.data;
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).getOrdersModel!.data!.date!.length > 0,
          builder: (context) => ConditionalBuilder(
            condition: ShopLayoutCubit.get(context).getOrdersModel!.data!.date!.isNotEmpty &&
                state is! ShopLoadingCancelOrdersState,
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) =>Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Order ID:",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        model!.id.toString(),
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${model.date}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.6),
                                      fontFamily: "Cairo",
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Cost : ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "${model.cost} LE",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Cairo",
                                          color: Colors.yellow,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "VAT : ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "${model.vat} LE",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Cairo",
                                          color: Colors.yellow,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Total Amount : ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "${model.total} LE",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Cairo",
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => Container(),
                    itemCount: ShopLayoutCubit.get(context).getOrdersModel!.data!.date!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),

        );
      },
    );
  }

  Widget buildOrderItem(OrderDetailsData model, context, state) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Order ID:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      model.id.toString(),
                      style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${model.date}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.6),
                    fontFamily: "Cairo",
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Cost : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${model.cost} LE",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "VAT : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${model.vat} LE",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text(
                  "Total Amount : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${model.total} LE",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    ),
  );


}
