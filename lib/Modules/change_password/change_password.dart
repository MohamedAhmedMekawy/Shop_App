import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/login/cubit/cubit.dart';
import 'package:shopping_app/Modules/login/cubit/state.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';

class ChangePassword extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
      listener: (context, state) {
        if(state is ShopLayoutSuccessChangePasswordStates){
          if(state.changePasswordModel.status){
            currentPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
            showToast(text: state.changePasswordModel.message,
                state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Change Your Password',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: currentPasswordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value){
                            return value.length < 6 ? 'Must be at least 8 character' : null;
                          }, prefix: Icons.lock,
                          text: 'Current Password'),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: newPasswordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value){
                            return value.length < 8 ? 'Must be at least 8 character' : null;
                          }, prefix: Icons.lock,
                          text: 'New Password'),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: confirmPasswordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value){
                            return value.length < 8 ? 'Must be at least 8 character' : null;
                          }, prefix: Icons.lock,
                          text: 'Confirm Password'),
                      SizedBox(
                        height: 30,
                      ),

                      ConditionalBuilder(
                        condition: state is! ShopLayoutLoadingChangePasswordStates,
                        builder: (context) => Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            )
                          ),
                          child: MaterialButton(
                            child: Text(
                              'Change Password', style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                            ),
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                ShopRegisterCubit.get(context).changePassword(
                                    current_password: currentPasswordController.text,
                                    new_password: newPasswordController.text);
                              }
                            },
                          ),
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),),
            ),
          ),
        );
      },
    );
  }
}
