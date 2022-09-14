import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/login/cubit/state.dart';
import 'package:shopping_app/components/constance.dart';
import 'package:shopping_app/models/login_model.dart';
import 'package:shopping_app/models/user_model.dart';
import 'package:shopping_app/shared/end_points.dart';
import 'package:shopping_app/shared/network/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopLoginInitialStates());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeVisPassword(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopLoginChangeSuffixStates());
  }
  late LoginModel loginModel;
  void userLogin({
  required String email,
  required String password,
})
  {
    emit(ShopUserDataLoadingLoginStates());
    DioHelper.postData(
        url: LOGIN,
        data:{
          'email' : email,
          'password' : password
        }).then((value) {
          loginModel = LoginModel.fromJson(value.data);
          print(value.data);
          emit(ShopUserDataSuccessLoginStates(loginModel));
    }).catchError((error){
      emit(ShopUserDataErrorLoginStates(error.toString()));
      print(error.toString());
    });
  }
  ChangePasswordModel? changePasswordModel;

  void changePassword({
    required String current_password,
    required String new_password,
  }){
    emit(ShopLayoutLoadingChangePasswordStates());

    DioHelper.postData(
        url: CHANGE_PASSWARD,
        data:{
          'current_password' : current_password,
          'new_password' : new_password
        },
        token: token).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);
      emit(ShopLayoutSuccessChangePasswordStates(changePasswordModel!));
    }).catchError((error){
      print(error.toString());
    });
  }

  LoginModel? registerModel;

  void register({
  required String name,
  required String email,
  required String password,
  required String phone,
}){
    emit(ShopLayoutLoadingRegisterStates());

    DioHelper.postData(
        url: REGISTER,
        data: {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone
        },
    token: token).then((value) {
      registerModel = LoginModel.fromJson(value.data);
      emit(ShopLayoutSuccessRegisterStates(registerModel!));
    }).catchError((error){
      emit(ShopLayoutErrorRegisterStates(error.toString()));
      print(error.toString());
    });
  }
}