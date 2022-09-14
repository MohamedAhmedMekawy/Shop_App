import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/login/login_screen.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/components/constance.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/shared/remote/cache_helper.dart';

class ProfileScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if(state is ShopLayoutSuccessUpDateProfileStates){
          if(state.loginModel.status){
            showToast(text: state.loginModel.message,
                state: ToastState.SUCCESS);
          }else{
            showToast(text: state.loginModel.message,
                state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {

        var user = ShopLayoutCubit.get(context).userModel;

        nameController.text = user!.data!.name;
        emailController.text = user.data!.email;
        phoneController.text = user.data!.phone;
        return    Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Account' ,style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    TextFormField(
                       controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Name',
                        border: OutlineInputBorder()
                      ),
                      validator: (value){
                         if(value!.isEmpty){
                           return 'Please Enter Your Name';
                         }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                       controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email',
                        border: OutlineInputBorder()
                    ),
                      validator: (value){
                         if(value!.isEmpty){
                           return 'Please Enter Your Email';
                         }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                       controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Phone',
                          border: OutlineInputBorder()
                      ),
                      validator: (value){
                         if(value!.isEmpty){
                           return 'Please Enter Your Phone';
                         }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                        condition: state is! ShopLayoutLoadingUpDateProfileStates,
                        builder: (context) => Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: MaterialButton(
                            child: Text(
                              'UpDate Profile', style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ),
                            ),
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                ShopLayoutCubit.get(context).upDataProfile(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              }
                            },
                          ),
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),),
                    SizedBox(
                      height: 17,
                    ),
                    ConditionalBuilder(
                        condition: state is! ShopLayoutLoadingLogOutStates,
                        builder: (context) => Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: MaterialButton(
                            child: Text(
                              'Log Out', style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ),
                            ),
                            onPressed: (){
                            CacheHelper.removeData(key: 'token').then((value) {
                              if(value){
                                signOut(context);
                              }
                            });
                              }

                          ),
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),),
                  ],
                ),
              ),
            ),
          )
        );
      },

    );
  }
}
