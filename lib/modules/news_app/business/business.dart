import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstpro/layout/news_app/cubit/cubit.dart';
import 'package:firstpro/layout/news_app/cubit/states.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).business;
        return buildListNews(list,context);
      },

    );
  }
}
