import 'package:firstpro/layout/shop_app/cubit/states.dart';
import 'package:firstpro/models/categories_model/categories_model.dart';
import 'package:firstpro/models/change_favorites_model/change_favorites_model.dart';
import 'package:firstpro/models/favorites_model/favorites_model.dart';
import 'package:firstpro/models/login_shop_model/login_model.dart';
import 'package:firstpro/models/shop_model/shop_model.dart';
import 'package:firstpro/modules/shop_app/categories/categories_screen.dart';
import 'package:firstpro/modules/shop_app/favorites/favorites_screen.dart';
import 'package:firstpro/modules/shop_app/products/products_screen.dart';
import 'package:firstpro/modules/shop_app/settings/settings_screen.dart';
import 'package:firstpro/shared/components/constansts/constansts.dart';
import 'package:firstpro/shared/network/end_point/end_point.dart';
import 'package:firstpro/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  List<Widget> screen=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];
  int currentIndex=0;
  void changeBottomNav(int index)
  {
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }
   ShopModel? shopModel;
   Map<int,bool> favorites ={};
  void getHome()
  {
    emit(ShopLoadingHomeState());
    DioHelper.getData(
        url: Home,
      token:token
    ).then((value) {
      shopModel=ShopModel.formJson(value.data);
      print(shopModel!.status);
      shopModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeState());
    }).catchError((error){
      emit(ShopErrorHomeState());
      print(error.toString());
    });
  }
CategoriesModel? categoriesModel;
  void getCategories()
  {
    DioHelper.getData(
        url: CATEGORIES,
        token:token
    ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      emit(ShopErrorCategoriesState());
      print(error.toString());
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int idProduct)
  {
    favorites[idProduct]=!favorites[idProduct]!;
    emit(ShopSuccessChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        token:token,
      data: {
          'product_id':idProduct
      },
    ).then((value) {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(changeFavoritesModel!.status==false)
        {
          favorites[idProduct]=!favorites[idProduct]!;
        }
      else{
        getFavorites();
      }
      emit(ShopChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      favorites[idProduct]=!favorites[idProduct]!;
      emit(ShopErrorChangeFavoritesState());
      print(error.toString());
    });
  }
    FavoritesModel? favoritesModel;
  void getFavorites()
  {
    DioHelper.getData(
        url: FAVORITES,
        token:token
    ).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessFavoritesState());
    }).catchError((error){
      emit(ShopErrorFavoritesState());
      print(error.toString());
    });
  }
    ShopLoginModel? userProfile;
  void getUserProfile()
  {
    emit(ShopLoadingProfileState());
    DioHelper.getData(
        url: PROFILE,
        token:token
    ).then((value) {
      userProfile=ShopLoginModel.fromJson(value.data);
      print(userProfile!.data!.name);
      emit(ShopSuccessProfileState());
    }).catchError((error){
      emit(ShopErrorProfileState());
      print(error.toString());
    });
  }

  void updateUserProfile({required String name,required String phone,required String email})
  {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token:token,
      data:
      {
        'name':name,
        'phone':phone,
        'email':email,
      },
    ).then((value) {
      userProfile=ShopLoginModel.fromJson(value.data);
      print(userProfile!.data!.name);
      emit(ShopSuccessUpdateUserState());
    }).catchError((error){
      emit(ShopErrorUpdateUserState());
      print(error.toString());
    });
  }
}