import 'package:firstpro/layout/shop_app/cubit/cubit.dart';
import 'package:firstpro/layout/shop_app/cubit/states.dart';
import 'package:firstpro/models/favorites_model/favorites_model.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:firstpro/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        if(ShopCubit.get(context).favoritesModel!=null){
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildProductsItem(ShopCubit.get(context).favoritesModel!.data!.favorites[index].products,context),
          separatorBuilder:(context,index)=>line() ,
          itemCount:ShopCubit.get(context).favoritesModel!.data!.favorites.length,
        );
        }else return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator()),
          ],
        );

      },
    ) ;
  }

}
