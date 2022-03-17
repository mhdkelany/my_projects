import 'package:firstpro/models/change_favorites_model/change_favorites_model.dart';
abstract class ShopStates{}
class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeState extends ShopStates{}

class ShopSuccessHomeState extends ShopStates{}

class ShopErrorHomeState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavoritesState extends ShopStates
{
  final ChangeFavoritesModel model;

  ShopChangeFavoritesState(this.model);
}

class ShopSuccessChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopSuccessFavoritesState extends ShopStates{}

class ShopErrorFavoritesState extends ShopStates{}

class ShopSuccessProfileState extends ShopStates{}

class ShopErrorProfileState extends ShopStates{}

class ShopLoadingProfileState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{}

class ShopErrorUpdateUserState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}