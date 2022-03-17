import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstpro/models/login_shop_model/login_model.dart';
import 'package:firstpro/modules/shop_app/login/login_cubit/states.dart';
import 'package:firstpro/modules/social_app/social_login/social_login_cubit/states.dart';
import 'package:firstpro/shared/network/end_point/end_point.dart';
import 'package:firstpro/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginSocialCubit extends Cubit<SocialLoginStates>
{
  LoginSocialCubit():super(SocialLoginInitialState());

  static LoginSocialCubit get(context)=>BlocProvider.of(context);
  void userLogin({required String email,required String password})
  {
    emit(SocialLoginLoadingState());
   FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password
   ).then((value) {
     emit(SocialLoginSuccessState());
     print(value.user!.email);
     print(value.user!.uid);
   }).catchError((error){
     print(error.toString());
     emit(SocialLoginErrorState(error.toString()));
   });
  }
  IconData suffix=Icons.visibility_off;
  bool isshow=true;
  void changePasswordVisibility()
  {
    isshow=!isshow;
    suffix=isshow?Icons.visibility_off:Icons.visibility;
    emit(ChangePasswordSocialVisibilityState());
  }
}