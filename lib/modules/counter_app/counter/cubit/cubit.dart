import 'package:bloc/bloc.dart';
import 'package:firstpro/modules/counter_app/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit():super(CounterInitialstate());
  static CounterCubit get(context)=>BlocProvider.of(context);
  int count=1;
  void plus()
  {
    count++;
    emit(CounterPlusState(count));
  }
  void minus()
  {
    count--;
    emit(CounterMinusState(count));
  }
}