import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstpro/layout/shop_app/cubit/cubit.dart';
import 'package:firstpro/layout/shop_app/cubit/states.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:firstpro/shared/components/constansts/constansts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var nameController=TextEditingController();
    var emailController=TextEditingController();
    var phoneController=TextEditingController();
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        if(ShopCubit.get(context).userProfile!=null) {
          nameController.text = ShopCubit
              .get(context)
              .userProfile!
              .data!
              .name;
          emailController.text = ShopCubit
              .get(context)
              .userProfile!
              .data!
              .email;
          phoneController.text = ShopCubit
              .get(context)
              .userProfile!
              .data!
              .phone;
        }
        return ConditionalBuilder(
          condition: state is!ShopLoadingProfileState,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserState)
                     LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    InputComponents(
                        controller: nameController,
                        text: 'Name',
                        prefix: Icons.person_outline,
                        inputType: TextInputType.text,
                        validate: (value)
                        {
                          if(value.isEmpty)
                          {
                            return 'name must be input';
                          }
                        }
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    InputComponents(
                        controller: emailController,
                        text: 'Email',
                        prefix: Icons.email_outlined,
                        inputType: TextInputType.emailAddress,
                        validate: (value)
                        {
                          if(value.isEmpty)
                          {
                            return 'email must be input';
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
                        validate: (value)
                        {
                          if(value.isEmpty)
                          {
                            return 'phone must be input';
                          }
                        }
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ButtonComponents(
                        function: ()
                        {
                          if(formKey.currentState!.validate())
                          ShopCubit.get(context).updateUserProfile(name: nameController.text, phone: phoneController.text, email: emailController.text);
                        },
                        text: 'update'.toUpperCase()
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ButtonComponents(
                        function: ()
                        {
                          logOut(context);
                        },
                        text: 'LogOut'.toUpperCase()
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
