import 'package:firstpro/layout/news_app/cubit/cubit.dart';
import 'package:firstpro/layout/news_app/cubit/states.dart';
import 'package:firstpro/modules/news_app/search/search_screen.dart';
import 'package:firstpro/shared/cubit/cubit.dart';
import 'package:firstpro/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(
                'News App'
            ),
            actions: [
              IconButton(icon: Icon(Icons.search),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));},),
              IconButton(icon: Icon(Icons.brightness_6_outlined),onPressed: (){ TodoCubit.get(context).changeMode();},)
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.item,
            currentIndex: cubit.current,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
          ),
          body: cubit.screens[cubit.current],
        );
      },
    );
  }
}
