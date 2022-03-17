import 'package:firstpro/layout/shop_app/cubit/cubit.dart';
import 'package:firstpro/layout/shop_app/cubit/states.dart';
import 'package:firstpro/models/categories_model/categories_model.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildListCategories(ShopCubit.get(context).categoriesModel!.data!.catData[index]),
            separatorBuilder:(context,index)=>line() ,
            itemCount: ShopCubit.get(context).categoriesModel!.data!.catData.length,
        );
      },
    );
  }
  Widget buildListCategories(Data data)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(data.image),
          width: 80,
          height: 80,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          data.name,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios
        ),
      ],
    ),
  );
}
