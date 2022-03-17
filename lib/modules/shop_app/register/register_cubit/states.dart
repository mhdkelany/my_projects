import 'package:firstpro/models/login_shop_model/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates
{
  final ShopLoginModel shopLoginModel;
  ShopRegisterSuccessState(this.shopLoginModel);
}
class ShopRegisterErrorState extends ShopRegisterStates
{
  final String error;

  ShopRegisterErrorState(this.error);
}
class ChangePasswordRegisterVisibilityState extends ShopRegisterStates{}
