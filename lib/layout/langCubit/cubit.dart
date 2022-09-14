import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shared/remote/cache_helper.dart';

class LangCubit extends Cubit<Locale?>{
  LangCubit() : super(null);
  static LangCubit get(context) => BlocProvider.of(context);
  
  changeStartLang() async {
    var langCode = await CacheHelper.getData(key: 'token');
    if(langCode != null){
      emit(Locale(langCode, ''));
    }
    else{
      emit(Locale('en' , ''));
    }
  }
  void changeLang(context, String data) async{
    emit(Locale(data, ''));
    await CacheHelper.saveData(key: 'token', value: data);
  }
}