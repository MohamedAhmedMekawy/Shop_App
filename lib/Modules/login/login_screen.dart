import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/Modules/login/cubit/cubit.dart';
import 'package:shopping_app/Modules/login/cubit/state.dart';
import 'package:shopping_app/Modules/register/register.dart';
import 'package:shopping_app/components/components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/layout/home_layot/layout_screen.dart';
import 'package:shopping_app/shared/remote/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopUserDataSuccessLoginStates){
            if(state.loginModel.status!){
             CacheHelper.saveData(
                 key: 'token',
                 value: state.loginModel.data!.token).then((value) {
                   navigateAndFinish(context, ShopLayoutScreen());
             });
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
            }else{

              showToast(
                  text: state.loginModel.message!,
                  state: ToastState.ERROR
              );
              print(state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return  Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 30),

                          ),
                          Text(
                            'Back !',
                            style:
                            GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold,fontSize: 30),
                          ),
                          SizedBox(
                              height: 10
                          ),
                          Text(
                            'Hey! Good to see you again',
                            style: GoogleFonts.asapCondensed(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'SIGN IN',
                            style:
                            GoogleFonts.abhayaLibre(
                                fontWeight: FontWeight.bold,fontSize: 30
                            ),
                          ),

                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'Please Enter Your Email';
                                }
                                return null;
                              },
                              prefix: Icons.email_outlined,
                              text: 'Email',
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Password';
                              }
                              return null;
                            },
                            prefix: Icons.lock,
                            text: 'Password',
                            suffixPressed: (){
                              cubit.changeVisPassword();
                            },
                            isPassword: cubit.isPassword,
                            suffix: cubit.suffix
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopUserDataLoadingLoginStates,
                            builder: (context) =>  Container(
                              height: 40,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blue,
                                child: MaterialButton(
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){
                                        ShopRegisterCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    child: Icon(Icons.arrow_forward_outlined)),
                              ),
                            ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
                          ),
                          Row(
                            children: [
                              Text(
                                'Don\'t have an account ?',
                                style: GoogleFonts.abel(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15
                                )
                              ),
                              Expanded(
                                child: defaultTextButton(
                                    function: (){
                                      navigateTo(context, RegisterScreen());
                                      },
                                    text: 'Register Now',
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
