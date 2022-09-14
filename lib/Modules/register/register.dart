import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/login/cubit/cubit.dart';
import 'package:shopping_app/Modules/login/cubit/state.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/components/constance.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/home_layot/layout_screen.dart';
import 'package:shopping_app/shared/remote/cache_helper.dart';

class RegisterScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
      listener: (context, state) {
        if(state is ShopLayoutSuccessRegisterStates){
          if(state.registerModel.status!){
            CacheHelper.saveData(key: 'token', value: state.registerModel.data!.token).then((value) {
              token = state.registerModel.data!.token;
              navigateAndFinish(context, ShopLayoutScreen());
            });
            showToast(text: state.registerModel.message!,
                state: ToastState.SUCCESS);
          }
          else{
            showToast(text: state.registerModel.message!,
                state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register', style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value){
                              if(value.isEmpty){
                                return 'Please Enter Your Name';
                              }
                            },
                            prefix: Icons.person,
                            text: 'Name'),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value.isEmpty){
                                return 'Please Enter Your Email';
                              }
                            },
                            prefix: Icons.email_outlined,
                            text: 'Email'),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value){
                              if(value.isEmpty){
                                return 'Please Enter Your Password';
                              }
                            },
                            prefix: Icons.lock,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            suffixPressed: (){
        ShopRegisterCubit.get(context).changeVisPassword();
        },
                              text: 'Password'),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value){
                              if(value.isEmpty){
                                return 'Please Enter Your Phone';
                              }
                            },
                            prefix: Icons.phone,
                            text: 'Phone'),
                        SizedBox(
                          height: 28,
                        ),

                        ConditionalBuilder(
                          condition: state is! ShopLayoutLoadingRegisterStates,
                          builder: (context) => Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)
                              )
                            ),
                            child: MaterialButton(
                              child: Text(
                                'Register', style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                              ),
                              ),
                                onPressed: (){
                              ShopRegisterCubit.get(context).register(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text);
                            }),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        )
                      ],
                    )),
              ),
            )
        );
      },
    );
  }
}
