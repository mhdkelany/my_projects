import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstpro/layout/shop_app/cubit/cubit.dart';
import 'package:firstpro/layout/shop_app/home_screen_shop.dart';
import 'package:firstpro/modules/shop_app/login/login_cubit/cubit.dart';
import 'package:firstpro/modules/shop_app/login/login_cubit/states.dart';
import 'package:firstpro/modules/shop_app/register/register_screen.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:firstpro/shared/components/constansts/constansts.dart';
import 'package:firstpro/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreenShop extends StatelessWidget {
  const LoginScreenShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailControl=TextEditingController();
    var passwordControl=TextEditingController();
    var formKey=GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) =>LoginShopCubit(),
      child: BlocConsumer<LoginShopCubit,ShopLoginStates>(
      listener: (context,state)
      {
        if(state is ShopLoginSuccessState)
          {
              if(state.shopLoginModel.status)
                {
                  print(state.shopLoginModel.message);
                 CacheHelper.putData(key: 'token', value: state.shopLoginModel.data?.token).then((value) {
                   token=state.shopLoginModel.data!.token;
                   print(token+'  ssss');
                   CacheHelper.getCacheData(key: 'token');
                   navigateToEnd(context, HomeScreenShop());
                   ShopCubit.get(context).getUserProfile();
                   ShopCubit.get(context).getFavorites();
                   ShopCubit.get(context).getCategories();
                   ShopCubit.get(context).getHome();
                 });
                  print(state.shopLoginModel.data?.token);

                }else{
                buildToast(state.shopLoginModel.message, loginState.ERROR);
                print(state.shopLoginModel.message);

              }
          }
      },
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      InputComponents(
                          controller: emailControl,
                          text: 'Email Address',
                          prefix: Icons.email_outlined,
                          inputType: TextInputType.emailAddress,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Enter your email please';
                            }
                          }
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InputComponents(
                          controller:passwordControl ,
                          text: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: LoginShopCubit.get(context).suffix,
                          onpressedsuffix: (){
                            LoginShopCubit.get(context).changePasswordVisibility();
                          },
                          isshow: LoginShopCubit.get(context).isshow,
                          inputType: TextInputType.visiblePassword,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Enter your password please';
                            }
                          }
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition:state is!ShopLoginLoadingState ,
                        builder: (context)=> ButtonComponents(
                          function: (){
                            if(formKey.currentState!.validate())
                            {
                              LoginShopCubit.get(context).userLogin(email: emailControl.text, password: passwordControl.text);
                              //ShopCubit.get(context).getUserProfile();
                            }
                          },
                          text: 'Login',
                        ),
                        fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don`t have an account?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          TextButton(
                              onPressed: ()
                              {
                                navigateTo(context, RegisterShopScreen());
                              }
                              , child: Text(
                              'Register'.toUpperCase()
                          )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      ),
    );
  }
}
