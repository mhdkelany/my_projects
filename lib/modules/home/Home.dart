import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 20.0,
        foregroundColor: Colors.white,
        leadingWidth: 35.5,
        shadowColor: Colors.black87,
        excludeHeaderSemantics: true,
        titleTextStyle: TextStyle(fontStyle:FontStyle.italic ),
        automaticallyImplyLeading:false ,
        backgroundColor: Colors.red,
        leading: Icon(
        Icons.menu
        ),
        title: Text(
            'This Is Test Application'
        ),
        actions: [
        //   Icon(
        //   Icons.search
        // )
        IconButton(onPressed: onclick, icon: Icon(Icons.search))
        ],
      ),
        body:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd:Radius.circular(20)
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(
                     image: NetworkImage(
                       'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Y2hhbmdlfGVufDB8fDB8fA%3D%3D&w=1000&q=80'
                     ),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,

                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      color: Colors.black.withOpacity(.7),
                      width: 200,
                      alignment: Alignment.center,
                      child: Text(
                        'Flutter',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
        // body: SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Container(
        //     height: double.infinity,
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: [
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //         Text('hhhh',style: TextStyle(fontSize: 30),),
        //       ],
        //     ),
        //   ),
        // ),
      // body: Container(
      //   color: Colors.teal,
      //   width: double.infinity,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     children: [
      //       Container(
      //         color: Colors.deepPurple,
      //          child: Text(
      //            'hello',
      //            style: TextStyle(
      //              color: Colors.redAccent,
      //              fontSize: 20.0,
      //              backgroundColor: Colors.lightBlueAccent,
      //            ),
      //          ),
      //        ),
      //       // Container(
      //       // child: Text(
      //       //   'Hi flutter',
      //       //   style: TextStyle(
      //       //     color: Colors.black,
      //       //     fontSize: 20.0,
      //       //     backgroundColor: Colors.red,
      //       //   ),
      //       // ),
      //       // ),
      //       // Container(
      //       //   child: Text(
      //       //     'mohmmad kelany',
      //       //     style: TextStyle(
      //       //       color: Colors.pink,
      //       //       fontSize: 20.0,
      //       //       backgroundColor: Colors.yellow,
      //       //     ),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
      );

  }
  void onclick()
  {
    print('im programer');
  }
}