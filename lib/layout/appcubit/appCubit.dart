
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/appcubit/appState.dart';
import 'package:shopping_app/shared/remote/cache_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialModeTheme());

  static AppCubit get(context) => BlocProvider.of(context);


  bool isDark = false;
  ThemeMode appMode = ThemeMode.dark;

  void changeAppMode({
  bool? fromShared
}){

    if(fromShared != null){
    isDark = fromShared;}
    else{
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
    emit(AppChangeModeTheme());
      });
    }
  }
}
