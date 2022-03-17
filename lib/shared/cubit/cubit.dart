import 'package:bloc/bloc.dart';
import 'package:firstpro/modules/todo_app/archive/TasksArchives.dart';
import 'package:firstpro/modules/todo_app/editTask/edit_task.dart';
import 'package:firstpro/modules/todo_app/new%20tasks/NewTask.dart';
import 'package:firstpro/modules/todo_app/tasks%20done/TasksDone.dart';
import 'package:firstpro/shared/cubit/states.dart';
import 'package:firstpro/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
class TodoCubit extends Cubit<AppStates>
{
  TodoCubit():super(InitialAppState());
  static TodoCubit get(context)=>BlocProvider.of(context);
  int currentscreens=0;
  List<Map> newtasks=[];
  List<Map> donetasks=[];
  List<Map> archivetasks=[];
  List<Widget> screens=[
    NewTask(),
    TasksDone(),
    TaskArchives(),
  ];
  List<String>nameappbar=[
    'New Tasks',
    'Done Tasks',
    'Tasks Archives',
  ];
  void changeBottomnav(int index)
  {
    currentscreens=index;
    emit(ChangeStateBottomNavBar());
  }
  late Database open;
 void createDatabase()
  {
      openDatabase(
        'todo.db',
        version: 1,

        onCreate: (database,version)async
        {
          print('Created success');
          await database.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)'
          );
        },
        onOpen: (database)
        {
          print('Opened success');
          getData(database);
        }
    ).then((value)  {
      open= value;
      emit(CreateDatabaseState());
    })  ;
  }
   insertToDatabase(
      {
        required String title,
        required String date,
        required String time,
        required BuildContext context
      }
      )async
  {
     await open.transaction((txn) {
      return  txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status)VALUES("$title","$date","$time","new")'
      ).then((value){
        print('$value inserted success');
        emit(InsertDataIntoDatabaseState());
           Navigator.pop(context);
        getData(open);
      }).catchError((error){print('$error sss');});
    });
  }
  void getData(open)async
  {
    newtasks=[];
    donetasks=[];
    archivetasks=[];
    emit(GetDataFromDatabaseLoadingState());
      await open.rawQuery(
        'select * from tasks'
    ).then((value) {
      print(value);
      value.forEach((element) {
      if(element['status']=='new')
        {
          newtasks.add(element);
        }else if(element['status']=='done')
          {
            donetasks.add(element);
          }else archivetasks.add(element);
    });
      emit(GetDataFromDatabaseState());
    });;
  }
  void updateTask({required String date,required String time,required String title,required BuildContext context,required int id})async
  {

    await open.rawUpdate(
      'update tasks set title=?,time=?,date=? where id=?',['$title','$time','$date',id]
    ).then((value) {
      emit(UpdateDataTaskFromDatabaseState());
     changeScreen(context);
      getData(open);
    });
  }
  void changeScreen(BuildContext context)
  {
    Navigator.pop(context);
    emit(ChangeScreenToNewTaskState());
  }
  void changeScreenToUpdateTask({required String date,required String time,required String title,required BuildContext context,required int id})
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTask(title: title, date: date, time: time, id: id)));
    emit(ChangeScreenToUpdateTaskState());

  }
  void updateData({required String status,required int id})
  {
    open.rawUpdate(
      'update tasks set status=? where id=?',['$status',id],
    ).then((value) {
      emit(UpdateDataFromDatabaseState());
      getData(open);
    });
  }
  void DeleteData({required int id}) async
  {
   await open.rawDelete(
      'delete from tasks where id=?',[id]
    ).then((value) {
      getData(open);
      emit(DeleteDataFromDatabaseState());
    });

  }
  bool isshowbottom=false;
  IconData iconData=Icons.edit;
  void changeBottomSheet({ required bool Isshow,required IconData icon})
  {
    isshowbottom=Isshow;
    iconData=icon;
    emit(ChangeStateBottomSheet());
  }
  bool isdark=false;
  void changeMode({bool? fromcache})
  {
    if(fromcache!=null)
      {
        isdark=fromcache;
        emit(ChangeModeState());
      }else {
      isdark = !isdark;
      CacheHelper.putBoolean(key: 'isdark', value: isdark).then((value) {
        emit(ChangeModeState());
      });
    }
  }
}