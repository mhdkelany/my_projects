
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstpro/layout/shop_app/cubit/cubit.dart';
import 'package:firstpro/layout/shop_app/cubit/states.dart';
import 'package:firstpro/models/categories_model/categories_model.dart';
import 'package:firstpro/models/shop_model/shop_model.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:firstpro/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
        if(state is ShopChangeFavoritesState)
          {
            if(!state.model.status)
              {
                buildToast(state.model.message, loginState.ERROR);
              }
          }
      },
      builder: (context,state)
      {
        return  ConditionalBuilder(
            condition: ShopCubit.get(context).shopModel!=null&&ShopCubit.get(context).categoriesModel!=null,
            builder: (context)=>buildProducts(ShopCubit.get(context).shopModel!,ShopCubit.get(context).categoriesModel!,context),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );


  }
  Widget buildProducts(ShopModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data!.banners.map((e) => Image(image: NetworkImage(e.image),fit: BoxFit.cover,)).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal
            ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600
                ),
              ),
             Container(
               height: 100,
               child: ListView.separated(
                 physics: BouncingScrollPhysics(),
                    scrollDirection:Axis.horizontal,
                   itemBuilder: (context,index)=>buildCategories(categoriesModel.data!.catData[index]),
                   separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                   itemCount: categoriesModel.data!.catData.length
               ),
             ) ,
              SizedBox(
                height: 10.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
               childAspectRatio: 1/1.7,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
            children: List.generate(
                model.data!.products.length,
                    (index) =>buildGridProducts(model.data!.products[index],context)
            ),
          ),
        )
      ],
    ),
  );
  Widget buildGridProducts(ProductsModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                image:NetworkImage(model.image),
              width: double.infinity,
              height: 200,
            ),
            if(model.discount!=0)
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
        Padding(
          padding: const EdgeInsets.all(10.0),
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
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defultColor
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if(model.discount!=0)
                     Text(
                    '${model.oldPrice}',
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
                    color: ShopCubit.get(context).favorites[model.id]! ? Colors.red:Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  Widget buildCategories(Data data)=>Stack(
    alignment: AlignmentDirectional.bottomEnd,
    children: [
      Image(
        image:NetworkImage(data.image),
        fit: BoxFit.cover,
        width: 100,
        height: 100,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: AlignmentDirectional.center,
            width: 100,
            color: Colors.black54,
            child: Text(
              data.name,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    ],
  );
}
