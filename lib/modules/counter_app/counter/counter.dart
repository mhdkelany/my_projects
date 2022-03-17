
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Counter extends StatelessWidget {

@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (BuildContext context)=>CounterCubit()  ,
    child: BlocConsumer<CounterCubit,CounterStates>(
      listener: (context,state)
      {
        // if(state is CounterPlusState) print('pluses ${state.count}');
        // if(state is CounterMinusState) print('minues ${state.count}');
      },
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'counter'
            ),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: (){
                   CounterCubit.get(context).plus();
                  },
                  child: Text(
                      'PLUS'
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '${CounterCubit.get(context).count}',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                TextButton(
                  style: ButtonStyle(

                  ),
                  onPressed: (){
                    CounterCubit.get(context).minus();
                  },
                  child: Text(
                      'MINUS'
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
}


