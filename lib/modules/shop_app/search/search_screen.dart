import 'package:firstpro/layout/shop_app/cubit/cubit.dart';
import 'package:firstpro/modules/shop_app/search/cubit/cubit.dart';
import 'package:firstpro/modules/shop_app/search/cubit/states.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
 var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit,ShopSearchStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                InputComponents(
                    controller: searchController,
                    text: 'Search',
                    prefix: Icons.search,
                    inputType: TextInputType.text,
                    textonsubmet: (String value)
                    {
                      ShopSearchCubit.get(context).search(value);
                    },
                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'search must be input';
                      }
                    }
                ),
                SizedBox(
                  height: 10.0,
                ),
                if(state is ShopSearchLoadingState)
                LinearProgressIndicator(),
                SizedBox(
                  height: 10.0,
                ),
            if(state is ShopSearchSuccessState)
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildProductsItem(ShopSearchCubit.get(context).searchModel!.data!.products[index],context,isDiscount: false),
                separatorBuilder:(context,index)=>line() ,
                itemCount:ShopSearchCubit.get(context).searchModel!.data!.products.length,
              ),
            ),
              ],
            ),
          );
        },
      ),
    );
  }
}
