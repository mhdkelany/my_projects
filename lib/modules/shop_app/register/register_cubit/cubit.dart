import 'package:firstpro/models/login_shop_model/login_model.dart';
import 'package:firstpro/modules/shop_app/login/login_cubit/states.dart';
import 'package:firstpro/modules/shop_app/register/register_cubit/states.dart';
import 'package:firstpro/shared/network/end_point/end_point.dart';
import 'package:firstpro/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterShopCubit extends Cubit<ShopRegisterStates>
{
  late ShopLoginModel registerModel;
  RegisterShopCubit():super(ShopRegisterInitialState());

  static RegisterShopCubit get(context)=>BlocProvider.of(context);
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email': '$email',
          'password':password,
          'name':name,
          'phone':phone,
        },
    ).then((value) {
      registerModel= ShopLoginModel.fromJson(value.data);
      print(value.data);
    emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_off;
  bool isshow=true;
  void changePasswordVisibility()
  {
    isshow=!isshow;
    suffix=isshow?Icons.visibility_off:Icons.visibility;
    emit(ChangePasswordRegisterVisibilityState());
  }
}