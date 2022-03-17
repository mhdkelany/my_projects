import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstpro/layout/BottomNavigtion.dart';
import 'package:firstpro/layout/news_app/cubit/cubit.dart';
import 'package:firstpro/layout/news_app/cubit/states.dart';
import 'package:firstpro/layout/news_app/newshome.dart';
import 'package:firstpro/layout/shop_app/cubit/cubit.dart';
import 'package:firstpro/modules/home/Home.dart';
import 'package:firstpro/modules/login/LoginScreen.dart';
import 'package:firstpro/modules/messenger/MessengerScreen.dart';
import 'package:firstpro/modules/shop_app/login/login_screen.dart';
import 'package:firstpro/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:firstpro/modules/shop_app/register/register_screen.dart';
import 'package:firstpro/modules/social_app/social_login/social_login_screen.dart';
import 'package:firstpro/modules/users/UsersModels.dart';
import 'package:firstpro/shared/bloc_observer.dart';
import 'package:firstpro/shared/components/constansts/constansts.dart';
import 'package:firstpro/shared/cubit/cubit.dart';
import 'package:firstpro/shared/cubit/states.dart';
import 'package:firstpro/shared/network/local/cache_helper.dart';
import 'package:firstpro/shared/network/remote/dio_helper.dart';
import 'package:firstpro/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/shop_app/home_screen_shop.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
        (){
    },
    blocObserver: MyBlocObserver(),
  );
DioHelper.init();
await CacheHelper.init();
 bool ?isdark=CacheHelper.getCacheData(key: 'isdark');
 bool ?isBoardEnd=CacheHelper.getCacheData(key: 'boarding');
  token=CacheHelper.getCacheData(key: 'token');
  print(token);
 Widget widget;
 if(isBoardEnd!=null)
   {
     if(token!=null)
       {
        widget= HomeScreenShop();
       }else widget=LoginScreenShop();
   }
 else
   {
    widget= OnBoardingScreen();
   }
if(isdark==null)
  isdark=true;

runApp(myApp(isdark,widget));
}
class myApp extends StatelessWidget
{
  final Widget startApp;
  final bool isdark;
  myApp(this.isdark,this.startApp);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (BuildContext context) =>NewsCubit()..getBusiness(),),
        BlocProvider(create: (BuildContext context) =>TodoCubit()..changeMode(fromcache: isdark),),
        BlocProvider(create: (BuildContext context) =>ShopCubit()..getHome()..getCategories()..getFavorites()..getUserProfile(),)
      ],
      child: BlocConsumer<TodoCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            theme: lightMode,
            darkTheme:darkMode ,
            themeMode: TodoCubit.get(context).isdark?ThemeMode.light:ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:SocialLoginScreen(),
          );
        },
      ),
    );

  }

}

