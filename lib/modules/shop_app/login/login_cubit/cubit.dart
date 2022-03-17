import 'package:firstpro/models/login_shop_model/login_model.dart';
import 'package:firstpro/modules/shop_app/login/login_cubit/states.dart';
import 'package:firstpro/shared/network/end_point/end_point.dart';
import 'package:firstpro/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginShopCubit extends Cubit<ShopLoginStates>
{
  late ShopLoginModel loginModel;
  LoginShopCubit():super(ShopLoginInitialState());

  static LoginShopCubit get(context)=>BlocProvider.of(context);
  void userLogin({required String email,required String password})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: Login,
        data: {
          'email': email,
          'password':password
        },
    ).then((value) {
    loginModel= ShopLoginModel.fromJson(value.data);
      print(value.data);
    emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_off;
  bool isshow=true;
  void changePasswordVisibility()
  {
    isshow=!isshow;
    suffix=isshow?Icons.visibility_off:Icons.visibility;
    emit(ChangePasswordVisibilityState());
  }
}