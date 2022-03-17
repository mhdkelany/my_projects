import 'package:firstpro/models/search_model/search_model.dart';
import 'package:firstpro/modules/shop_app/search/cubit/states.dart';
import 'package:firstpro/shared/components/constansts/constansts.dart';
import 'package:firstpro/shared/network/end_point/end_point.dart';
import 'package:firstpro/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>
{
  ShopSearchCubit():super(ShopSearchInitialState());
  static ShopSearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? searchModel;
  void search(String text)
  {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: PRODUCTS_SEARCH,
        token: token,
        data:
        {
          'text':text
        },
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}