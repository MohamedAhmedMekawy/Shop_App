import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/address/AddAddress.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/models/address_model.dart';
import 'package:shopping_app/models/updateAddress_model.dart';

class AddressesScreen extends StatelessWidget {

  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){

      },
      builder: (context,state){
        return Scaffold(

          bottomSheet: Container(
            width: double.infinity,
            height: 50,

            child: MaterialButton(
              onPressed: (){
                navigateTo(context, AddOrUpDateAddress(isEdit: false,));
              },
              color: Colors.blue,
              //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              child: Text('ADD A NEW ADDRESS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ),

          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder:(context,index) => ShopLayoutCubit.get(context).addressModel!.data!.data!.length == 0?
                        Container():
                        addressItem(ShopLayoutCubit.get(context).addressModel!.data!.data![index],context),
                        separatorBuilder:(context,index) => Container(),
                        itemCount: ShopLayoutCubit.get(context).addressModel!.data!.data!.length
                    ),
                    Container(height: 70,width: double.infinity,)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget addressItem(AddressData model,context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,color: Colors.green,),
              SizedBox(width: 5,),
              Text (model.name!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Spacer(),
              TextButton(
                  onPressed: (){
                    ShopLayoutCubit.get(context).deleteAddress(addressId: model.id);
                  },
                  child: Row(children:
                  [
                    Icon(Icons.delete_outline,size: 17,),
                    Text('Delete')
                  ],)
              ),
              Container(height: 20,width: 1,color: Colors.grey[300],),
              TextButton(
                  onPressed: (){
                    navigateTo(context, AddOrUpDateAddress(
                      isEdit: true,
                      addressId: model.id,
                      name: model.name,
                      city: model.city,
                      region: model.region,
                      details: model.details,
                      notes: model.notes,
                    ));
                  },
                  child: Row(children:
                  [
                    Icon(Icons.edit,size: 17,color: Colors.grey,),
                    Text('Edit',style: TextStyle(color: Colors.grey),)
                  ],)
              ),


            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width : 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Region',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Details',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Notes',style: TextStyle(fontSize: 15,color: Colors.grey),),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.city!,style: TextStyle(fontSize: 15,)),
                  SizedBox(height: 10,),
                  Text(model.region!,style: TextStyle(fontSize: 15,)),
                  SizedBox(height: 10,),
                  Text(model.details!,style: TextStyle(fontSize: 15,)),
                  SizedBox(height: 10,),
                  Text(model.notes!,style: TextStyle(fontSize: 15,)),
                  //
                ],)
            ],
          ),
        ),
      ],
    );
  }
}
