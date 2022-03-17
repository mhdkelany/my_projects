import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstpro/modules/social_app/social_login/social_login_cubit/cubit.dart';
import 'package:firstpro/modules/social_app/social_login/social_login_cubit/states.dart';
import 'package:firstpro/modules/social_app/social_register/social_register_screen.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailControl=TextEditingController();
  var passwordControl=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginSocialCubit(),
      child: BlocConsumer<LoginSocialCubit,SocialLoginStates>(
        listener: (context,state)
        {
          if(state is SocialLoginErrorState)
            {
              buildToast(state.error,loginState.ERROR);
            }
        },
        builder: (context,state)
        {
          return Scaffold(
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
                          'Login now to communicate with friends',
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
                            suffix: LoginSocialCubit.get(context).suffix,
                            onpressedsuffix: (){
                              LoginSocialCubit.get(context).changePasswordVisibility();
                            },
                            isshow: LoginSocialCubit.get(context).isshow,
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
                          condition:state is!SocialLoginLoadingState ,
                          builder: (context)=> ButtonComponents(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                                 LoginSocialCubit.get(context).userLogin(email: emailControl.text, password: passwordControl.text);
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
                                  navigateTo(context, RegisterSocialScreen());
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
