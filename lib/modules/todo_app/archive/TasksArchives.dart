import 'package:firstpro/shared/components/components.dart';
import 'package:firstpro/shared/cubit/cubit.dart';
import 'package:firstpro/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskArchives extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildTask(tasks: TodoCubit.get(context).archivetasks);
      },
    );
  }
}
