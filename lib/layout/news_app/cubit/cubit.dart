import 'package:bloc/bloc.dart';
import 'package:firstpro/layout/news_app/cubit/states.dart';
import 'package:firstpro/modules/news_app/business/business.dart';
import 'package:firstpro/modules/news_app/science/science.dart';
import 'package:firstpro/modules/news_app/sports/sports.dart';
import 'package:firstpro/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() :super(InitialNewsState());

  static NewsCubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> item = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science'
    ),

  ];
  int current = 0;
  List<Widget>screens = [
    Business(),
    Sports(),
    Science(),

  ];

  void changeBottomNav(int index) {
    current = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(ChangeBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(GetBusinessDataLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'business',
          'apiKey': '74708df7d43b4aa088cafb1acbcf8500'
        }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(GetBusinessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(GetBusinessDataErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(GetSportsDataLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'us',
            'category': 'sports',
            'apiKey': '74708df7d43b4aa088cafb1acbcf8500'
          }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(GetSportsDataState());
      }).catchError((error) {
        print(error.toString());
        emit(GetSportsDataErrorState(error.toString()));
      });
    } else {
      emit(GetSportsDataState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(GetScienceDataLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'us',
            'category': 'science',
            'apiKey': '74708df7d43b4aa088cafb1acbcf8500'
          }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(GetScienceDataState());
      }).catchError((error) {
        print(error.toString());
        emit(GetScienceDataErrorState(error.toString()));
      });
    } else
      emit(GetScienceDataState());
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(GetSearchDataLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '74708df7d43b4aa088cafb1acbcf8500',
        }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(GetSearchDataState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchDataErrorState(error.toString()));
    });
  }
}