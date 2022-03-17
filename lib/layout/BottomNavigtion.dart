import 'package:conditional_builder/conditional_builder.dart';

import 'package:firstpro/shared/components/components.dart';
import 'package:firstpro/shared/components/constansts/constansts.dart';
import 'package:firstpro/shared/cubit/cubit.dart';
import 'package:firstpro/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';


class HomeLayout extends StatelessWidget {

  var scaffoldkey=GlobalKey<ScaffoldState>();

  var titlecontrole=TextEditingController();
  var timecontrole=TextEditingController();
  var datecontrole=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit,AppStates>(
        listener: (context,state)
        {
          if(state is ChangeStateBottomNavBar) print('Changed');
        },
        builder: (context,state)
        {
          return Scaffold(
            key: scaffoldkey,

            appBar: AppBar(
              title: Text(
                  TodoCubit.get(context).nameappbar[TodoCubit.get(context).currentscreens]
              ),
            ),
            body: ConditionalBuilder(
              condition: state is !GetDataFromDatabaseLoadingState,
              builder:(context)=>TodoCubit.get(context).screens[TodoCubit.get(context).currentscreens] ,
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ) ,
            floatingActionButton: FloatingActionButton(
              child: Icon(
                TodoCubit.get(context).iconData,
              ),
              onPressed: ()
              {
                if(TodoCubit.get(context).isshowbottom)
                {
                  if(formkey.currentState!.validate())
                  {
                    TodoCubit.get(context).insertToDatabase(title: titlecontrole.text, date: datecontrole.text, time: timecontrole.text,context: context);
                    TodoCubit.get(context).changeBottomSheet(Isshow: false, icon: Icons.edit);
                  }
                }
                else{
                  scaffoldkey.currentState!.showBottomSheet((context) =>
                      Container(
                        color: Colors.grey[100],
                        padding:EdgeInsets.all(20.0),
                        child: Form(
                          key: formkey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InputComponents(
                                  inputType: TextInputType.text,
                                  prefix: Icons.title,
                                  text: 'Task Title',
                                  controller: titlecontrole,
                                  validate: (String value)
                                  {
                                    if(value.isEmpty)
                                    {
                                      return'title must be input';
                                    }
                                  }
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              InputComponents(
                                  textonsubmet: (String? value)
                                  {
                                    print(value);
                                  },
                                  ontap: ()
                                  {
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now()
                                    ).then((value){
                                      timecontrole.text=value!.format(context);
                                    });
                                  },
                                  inputType: TextInputType.datetime,
                                  prefix: Icons.timelapse,
                                  text: 'Task Time',
                                  controller: timecontrole,
                                  validate: (String value)
                                  {
                                    if(value.isEmpty)
                                    {
                                      return'time must be input';
                                    }
                                  }

                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              InputComponents(
                                  textonsubmet: (String? value)
                                  {
                                    print(value);
                                  },
                                  ontap: ()
                                  {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-11-25'),
                                    ).then((value) {
                                      datecontrole.text=DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  inputType: TextInputType.datetime,
                                  prefix: Icons.calendar_today,
                                  text: 'Date Time',
                                  controller: datecontrole,
                                  validate: (String value)
                                  {
                                    if(value.isEmpty)
                                    {
                                      return'date must be input';
                                    }
                                  }
                              ),
                            ],
                          ),
                        ),
                      )

                  ).closed.then((value) {
                    TodoCubit.get(context).changeBottomSheet(Isshow: false, icon: Icons.edit);
                  });
                  TodoCubit.get(context).changeBottomSheet(Isshow: true, icon: Icons.add);
                }

              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon:Icon(Icons.menu),
                    label: 'Tasks'
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.check_circle_outline),
                    label: 'Done'
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.archive_outlined),
                    label: 'Archives'
                ),
              ],
              currentIndex: TodoCubit.get(context).currentscreens,
              onTap: (index){
                TodoCubit.get(context).changeBottomnav(index);
              },
            ),
          );
        },
      ),
    );
  }


}
