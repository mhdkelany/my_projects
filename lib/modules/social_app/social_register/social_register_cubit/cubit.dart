import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstpro/models/social_app_models/social_user_model/social_user_model.dart';
import 'package:firstpro/modules/social_app/social_register/social_register_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterSocialCubit extends Cubit<SocialRegisterStates>
{
  RegisterSocialCubit():super(SocialRegisterInitialState());

  static RegisterSocialCubit get(context)=>BlocProvider.of(context);
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(SocialRegisterLoadingState());
   FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email
       , password: password
   ).then((value) {
     print(value.user!.email);
     print(value.user!.uid);
     createUser(
         email: email,
         uId: value.user!.uid,
         name: name,
         phone: phone
     );
    // emit(SocialRegisterSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(SocialRegisterErrorState(error.toString()));
   });
  }
  void createUser({
    required String email,
    required String uId,
    required String name,
    required String phone,
})
  {
    SocialUserModel model=SocialUserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(SocialCreateUserSuccessState());
          print(uId);
    }).catchError((error){
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_off;
  bool isshow=true;
  void changePasswordVisibility()
  {
    isshow=!isshow;
    suffix=isshow?Icons.visibility_off:Icons.visibility;
    emit(ChangePasswordSocialRegisterVisibilityState());
  }
}