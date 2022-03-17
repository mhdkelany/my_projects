import 'package:firstpro/layout/news_app/cubit/cubit.dart';
import 'package:firstpro/layout/news_app/cubit/states.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {

  var searchControl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InputComponents(
                    controller: searchControl,
                    text: 'Search',
                    prefix: Icons.search,
                    inputType: TextInputType.text,
                    textonchanged: (value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    validate: (String value){
                      if(value.isEmpty)
                      {
                        return 'must input';
                      }
                    }
                ),
              ),
              Expanded(child: buildListNews(list, context,issearch: true)),
            ],
          ),
        );
      },
    );
  }
}
