import 'package:firstpro/shared/components/components.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
var emailcontroll=TextEditingController();

var passwordcontroll=TextEditingController();

var keyform=GlobalKey<FormState>();

bool isobscure=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key:keyform ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello Again!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InputComponents(
                      controller: emailcontroll,
                      text:'Email Address',
                      prefix: Icons.email,
                      inputType: TextInputType.emailAddress,
                    validate: (String value){
                      if(value.isEmpty)
                      {
                        return 'email must input';
                      }
                    }
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputComponents(
                    onpressedsuffix: (){
                      setState(() {
                        isobscure=!isobscure;
                      });
                    },
                    isshow: isobscure,
                      suffix: isobscure? Icons.visibility:Icons.visibility_off,
                      controller: passwordcontroll,
                      text: 'Password',
                      prefix: Icons.lock,
                      inputType: TextInputType.visiblePassword,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return 'password must input';
                        }
                      }
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ButtonComponents(
                    function: (){
                      if(keyform.currentState!.validate())
                        {
                          print(emailcontroll.text);
                          print(passwordcontroll.text);
                        }
                    },
                    text: 'login',
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont Have An Account?'
                      ),
                      TextButton(
                        onPressed: (){}, child:
                      Text(
                        'Regster Now'
                      ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
