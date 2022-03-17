import 'package:firstpro/layout/shop_app/cubit/cubit.dart';
import 'package:firstpro/layout/shop_app/cubit/states.dart';
import 'package:firstpro/modules/news_app/search/search_screen.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenShop extends StatelessWidget {
List<String>nameAppBar=[
  'Products',
  'Categories',
  'Favorites',
  'Settings'
];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
                nameAppBar[ShopCubit.get(context).currentIndex]
            ),
            actions: [
              IconButton(onPressed: ()
              {
                navigateTo(context, SearchScreen());
              },
                  icon: Icon(Icons.search),
              )
            ],
          ),
          body: ShopCubit.get(context).screen[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap: (index)
            {
              ShopCubit.get(context).changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
