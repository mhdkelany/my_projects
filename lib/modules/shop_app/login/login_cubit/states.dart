import 'package:firstpro/models/login_shop_model/login_model.dart';

abstract class ShopLoginStates{}
class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates
{
  final ShopLoginModel shopLoginModel;
  ShopLoginSuccessState(this.shopLoginModel);
}
class ShopLoginErrorState extends ShopLoginStates
{
  final String error;

  ShopLoginErrorState(this.error);
}
class ChangePasswordVisibilityState extends ShopLoginStates{}
