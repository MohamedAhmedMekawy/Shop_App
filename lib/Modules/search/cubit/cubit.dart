import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/search/cubit/states.dart';
import 'package:shopping_app/components/constance.dart';
import 'package:shopping_app/models/search_model.dart';
import 'package:shopping_app/shared/end_points.dart';
import 'package:shopping_app/shared/network/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? search;

  void searchModel(String? text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        data: {
          'text' : text
        },
    token: token).then((value) {
      search =SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }
}