import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/address/getAddress.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';

class AddOrUpDateAddress extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  var formKey = GlobalKey<FormState>();

    bool isEdit;
    int? addressId;
    String? name;
    String? city;
    String? region;
    String? details;
    String? notes;

  AddOrUpDateAddress({
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes
});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context,state) {
        if(state is ShopLayoutSuccessAddOrdersStates){
          if(state.addOrderModel.status){
            showToast(text: state.addOrderModel.message, state: ToastState.SUCCESS);
          }
        }

        if (state is ShopLayoutSuccessUpDateAddressStates){
          if (state.upDateAddressModel.status!)
            Navigator.pop(context);
        }
        else if (state is ShopLayoutSuccessAddAddressStates)
          if(state.addAddressModel.status)
            Navigator.pop(context);
      },
      builder: (context, state) {
        if(isEdit){
          nameController.text = name!;
          cityController.text = city!;
          regionController.text = region!;
          detailsController.text = details!;
          notesController.text = notes!;
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, child: Text(
                'CANCEL',
              style: TextStyle(
                color: Colors.blue
              ),))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLayoutLoadingAddAddressStates || state is ShopLayoutLoadingUpDateAddressStates)
                      Column(
                        children: [
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    Text(
                      'Location Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value){
                        if(value!.isEmpty){
                          return ' Please Enter Your Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person)
                      ),
                    ),
                    TextFormField(
                      controller: cityController,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        if(value!.isEmpty){
                          return ' Please Enter Your City';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'City',
                          prefixIcon: Icon(Icons.location_city)
                      ),
                    ),
                    TextFormField(
                      controller: regionController,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        if(value!.isEmpty){
                          return ' Please Enter Your Region';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Region',
                          prefixIcon: Icon(Icons.location_on)
                      ),
                    ),
                    TextFormField(
                      controller: detailsController,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        if(value!.isEmpty){
                          return ' Please Enter Your Details';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Details',
                          prefixIcon: Icon(Icons.details_outlined)
                      ),
                    ),
                    TextFormField(
                      controller: notesController,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        if(value!.isEmpty){
                          return ' Please Enter Your Notes';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Notes',
                          prefixIcon: Icon(Icons.note_alt_outlined)
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )
                      ),
                      child: ElevatedButton(
                          onPressed: (){
                        if(formKey.currentState!.validate()){
                          if(isEdit){
                            ShopLayoutCubit.get(context).updateAddress(
                                addressId: addressId,
                                name: nameController.text,
                                city: cityController.text,
                                region: regionController.text,
                                details: detailsController.text,
                                notes: notesController.text);
                          }
                          else{
                            ShopLayoutCubit.get(context).addAddress(
                                name: nameController.text,
                                city: cityController.text,
                                region: regionController.text,
                                details: detailsController.text,
                                notes: notesController.text);
                          }
                        }
                        print(notesController.text);
                      }, child: Text(
                        'SAVE ADDRESS', style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                      )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
