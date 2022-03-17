import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstpro/layout/social_app/social_home_screen.dart';
import 'package:firstpro/modules/social_app/social_register/social_register_cubit/cubit.dart';
import 'package:firstpro/modules/social_app/social_register/social_register_cubit/states.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterSocialScreen extends StatelessWidget {
      var formKey=GlobalKey<FormState>();
      var emailControl=TextEditingController();
      var phoneController=TextEditingController();
      var nameController=TextEditingController();
      var passwordControl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>RegisterSocialCubit(),
      child: BlocConsumer<RegisterSocialCubit,SocialRegisterStates>(
        listener: (context,state)
        {
          if(state is SocialCreateUserSuccessState)
            {
              navigateToEnd(context, SocialHomeScreen());
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
                          'Register now to communicate with friends',
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
                            suffix: RegisterSocialCubit.get(context).suffix,
                            onpressedsuffix: (){
                              RegisterSocialCubit.get(context).changePasswordVisibility();
                            },
                            isshow: RegisterSocialCubit.get(context).isshow,
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
                          condition:state is ! SocialRegisterLoadingState,
                          builder: (context)=> ButtonComponents(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                               // ShopCubit.get(context).currentIndex=0;
                                RegisterSocialCubit.get(context).userRegister(email: emailControl.text, password: passwordControl.text,phone:phoneController.text,name:nameController.text);
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
        }
      ),
    );
  }
}
