import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstpro/layout/shop_app/cubit/cubit.dart';
import 'package:firstpro/layout/shop_app/home_screen_shop.dart';
import 'package:firstpro/modules/shop_app/login/login_cubit/cubit.dart';
import 'package:firstpro/modules/shop_app/login/login_screen.dart';
import 'package:firstpro/modules/shop_app/register/register_cubit/cubit.dart';
import 'package:firstpro/modules/shop_app/register/register_cubit/states.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:firstpro/shared/components/constansts/constansts.dart';
import 'package:firstpro/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterShopScreen extends StatelessWidget {
      var formKey=GlobalKey<FormState>();
      var emailControl=TextEditingController();
      var phoneController=TextEditingController();
      var nameController=TextEditingController();
      var passwordControl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>RegisterShopCubit(),
      child: BlocConsumer<RegisterShopCubit,ShopRegisterStates>(
        listener: (context,state)
        {
          if(state is ShopRegisterSuccessState)
          {
            print('hhhh');
            if(state.shopLoginModel.status)
            {
              print(state.shopLoginModel.message);
              CacheHelper.putData(key: 'token', value: state.shopLoginModel.data?.token).then((value) {
                token=state.shopLoginModel.data!.token;
                buildToast(state.shopLoginModel.message, loginState.SUCCESS);
                navigateToEnd(context, LoginScreenShop());
              });
              print(state.shopLoginModel.data?.token);

            }else{
              buildToast(state.shopLoginModel.message, loginState.ERROR);
              print(state.shopLoginModel.message);

            }
          }
        },
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(
            ),
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
                          'Register'.toUpperCase(),
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        InputComponents(
                            controller: nameController,
                            text: 'Name',
                            prefix: Icons.person_outline,
                            inputType: TextInputType.name,
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Enter your name please';
                              }
                            }
                        ),
                        SizedBox(
                          height: 20.0,
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
                            controller: phoneController,
                            text: 'Phone',
                            prefix: Icons.phone_outlined,
                            inputType: TextInputType.number,
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Enter your phone please';
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
                            suffix: RegisterShopCubit.get(context).suffix,
                            onpressedsuffix: (){
                              RegisterShopCubit.get(context).changePasswordVisibility();
                            },
                            isshow: RegisterShopCubit.get(context).isshow,
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
                          condition:state is ! ShopRegisterLoadingState,
                          builder: (context)=> ButtonComponents(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                               // ShopCubit.get(context).currentIndex=0;
                                RegisterShopCubit.get(context).userRegister(email: emailControl.text, password: passwordControl.text,phone:phoneController.text,name:nameController.text);
                              }
                            },
                            text: 'Register',
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
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
