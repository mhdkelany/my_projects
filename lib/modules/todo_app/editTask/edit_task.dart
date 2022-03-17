
import 'package:firstpro/shared/components/components.dart';
import 'package:firstpro/shared/cubit/cubit.dart';
import 'package:firstpro/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditTask extends StatelessWidget {

  var titlecontrole=TextEditingController();
  var timecontrole=TextEditingController();
  var datecontrole=TextEditingController();
  var formkey=GlobalKey<FormState>();
  String title;
  String date;
  String time;
  int id;
  EditTask({required this.title,required this.date,required this.time,required this.id});

  @override
  Widget build(BuildContext context) {

          return  BlocProvider(
            create: (BuildContext context) =>TodoCubit(),
            child: BlocConsumer<TodoCubit,AppStates>(
              listener: (context,state){if(state is GetDataFromDatabaseState) print('hhhh');},//if(state is UpdateDataTaskFromDatabaseState){Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTask()));}},
              builder: (context,state)
              {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                        'Edit Task'
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(

                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 40.0,
                                  child: Text(
                                      '$time'
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$title',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0
                                        ),
                                      ),
                                      Text(
                                        '$date',
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  InputComponents(controller: titlecontrole,
                                      ontap: (){},

                                      text: 'Title',
                                      prefix: Icons.title,
                                      inputType: TextInputType.text,
                                      validate: (String value)
                                      {
                                        if(value.isEmpty)
                                        {
                                          return 'Title Must Input';
                                        }
                                      }
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  InputComponents(
                                      textonchanged: (){},
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
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  MaterialButton(
                                    onPressed: (){
                                      if(formkey.currentState!.validate())
                                      {
                                        TodoCubit.get(context).updateTask(date: datecontrole.text, time: timecontrole.text, title: titlecontrole.text, context: context,id: id);
                                      }
                                    },
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                          color: Colors.white
                                      ),

                                    ),
                                    color: Colors.blue,
                                  )
                                ],
                              ),

                            ),
                          ],
                        ),
                      ),
                    ),

                  ),

                );
              },
            ),
          );
        }


  }

