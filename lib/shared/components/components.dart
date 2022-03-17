import 'dart:io';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstpro/layout/shop_app/cubit/cubit.dart';
import 'package:firstpro/models/favorites_model/favorites_model.dart';
import 'package:firstpro/modules/news_app/web_view_news/web_view_screen.dart';
import 'package:firstpro/shared/cubit/cubit.dart';
import 'package:firstpro/shared/cubit/states.dart';
import 'package:firstpro/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget ButtonComponents({
  double width=double.infinity,
  Color color=Colors.blue,
  required  Function function,
  required String text,
  bool isupper=true,
})=>  Container(
  width: width,
  height: 45.0,
  color: color,
  child: MaterialButton(
    onPressed: (){function();} ,
    child: Text(
     isupper? text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),

  ),
);
Widget InputComponents({
  required TextEditingController controller,
  required String text,
  required IconData prefix,
  required TextInputType inputType,
  bool isshow=false,
  IconData? suffix,
  required  Function validate,
  Function? onpressedsuffix,
  Function? textonchanged,
  Function? textonsubmet,
  Function? ontap,
})=> TextFormField(

  controller: controller,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: text,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: IconButton(
      onPressed:(){
        if(onpressedsuffix!=null)
        onpressedsuffix();
      } ,
      icon: Icon(
        suffix
      ),
    )
  ),
  keyboardType: inputType,
  validator:  (value)=>validate(value),
  obscureText: isshow,
  onChanged: (String s){
    if(textonchanged!=null)
   textonchanged(s);
  },
  onFieldSubmitted: (s){
    if(textonsubmet!=null)
      {
        textonsubmet(s);
      }


  },
  onTap: (){
    if(ontap!=null)
    ontap();
  },
);
Widget buildTasks(Map models,context)=>Dismissible(
  key: Key(models['id'].toString()),
  onDismissed: (direction){
    TodoCubit.get(context).DeleteData(id: models['id']);
  },

  child:  Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
              '${models['time']}'
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${models['title']}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
              ),
              Text(
                '${models['date']}',
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
  
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
            onPressed: (){
              TodoCubit.get(context).updateData(status: 'done', id: models['id']);
            },
            icon: Icon(Icons.check_box),
          color: Colors.green,
        ),
        IconButton(
            onPressed: (){
              TodoCubit.get(context).updateData(status: 'archive', id: models['id']);
            },
            icon: Icon(Icons.archive),
          color: Colors.black45,
        ),
        TextButton(
            onPressed: (){
              TodoCubit.get(context).changeScreenToUpdateTask(date: models['date'], time: models['time'], title: models['title'], context: context, id: models['id']);
            },
            child: Text(
                'Edit'
            )
        ),
      ],
    ),
  ),
);
Widget BuildTask({required List<Map> tasks})=>ConditionalBuilder(
  condition: tasks.length>0,
  builder: (context)=> ListView.separated(
    itemBuilder: (context,index)=>buildTasks(tasks[index],context),
    separatorBuilder: (context,index)=>line(),
    itemCount:tasks.length,
  ),
  fallback: (context)=> Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Task',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
        ),
      ],
    ),
  ),
);
Widget buildArticle(article,context)=>InkWell(
  onTap: ()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(article['url'])));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image:  NetworkImage('${article['urlToImage']}'),

                  fit: BoxFit.cover
              )
          ),

        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
Widget line()=>Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget buildListNews(list,context,{issearch=false})=>ConditionalBuilder(
  condition:list.length>0 ,
  builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=>buildArticle(list[index],context),
    separatorBuilder: (context,index)=>line(),
    itemCount: list.length,
  ),
  fallback:(context)=>issearch?Container(): Center(child: CircularProgressIndicator()) ,
);
 navigateTo(BuildContext context,Widget widget)=>Navigator.push(context,MaterialPageRoute(builder: (context)=>widget));
 navigateToEnd(BuildContext context,Widget widget)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
void buildToast(String message,loginState state)=>Fluttertoast.showToast(
    msg: message ,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: changeColor(state),
    textColor: Colors.white,
    fontSize: 25.0
);
enum loginState{
 SUCCESS,WARNING,ERROR
}
Color changeColor(loginState login)
{
  Color color;
  switch(login)
  {
    case loginState.SUCCESS:
      color=Colors.green;
      break;
    case loginState.ERROR :
      color=Colors.red;
      break;
    case loginState.WARNING :
    color=Colors.yellow;
      break;

  }
  return color;
}
Widget buildProductsItem( model,context,{bool isDiscount=true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:NetworkImage(model.image),
              width: 120,
              height: 120,
            ),
            if(model.discount!=0&&isDiscount)
              Container(
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    height: 1.3
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.toString()}',
                    style: TextStyle(
                        fontSize: 12.0,
                        color: defultColor
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if(model.discount!=0&&isDiscount)
                    Text(
                      '${model.oldPrice.toString()}',
                      style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: Icon(Icons.favorite),
                    color: ShopCubit.get(context).favorites[model.id]!? Colors.red:Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
