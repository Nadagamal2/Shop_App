//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/shared/network/local/cashe_helper.dart';
import 'package:sqflite/sqflite.dart';






class AppCibit extends Cubit<AppStates>
{
  AppCibit() :super(AppIntialState());
  static AppCibit get(context)=>BlocProvider.of(context);
  int currentIndex =0;

  List<String> titles=[
    'Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  void changeIndex (int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }
  late Database database;

  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
      {
        print('database created');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status Text)').then((value) {
          print('table created');
        }).catchError((error){
          print('error when creating table${error.toString()}');
        });

      },
      onOpen: (database)
      {
        getDataFromDatabase(database);
        print('database opened');

      },
    ).then((value) {
      database=value;
      emit(AppCreateDatabaseState());
    });
  }
    insertDatabase({
    required String title,
    required String time,
    required String date,
  })async{

     await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")'
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error){
        print('error when inserting new record${error.toString()}');
      });
      // ignore: null_check_always_fails

    });
  }
 void getDataFromDatabase(database)

  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];

    emit( AppGetDatabaseLoadingState());

        database.rawQuery('SELECT * FROM tasks').then((value) {


      value.forEach((element) {
        if(element['status']=='new')
          newTasks.add(element);
        else if(element['status']=='Done')
          doneTasks.add(element);
        else
          archivedTasks .add(element);
      });
      emit(AppGetDatabaseState());



    });


  }
void updataData(
  {
       required String status,
    required int id,

  }
)async
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id ]
    ).then((value)
    {
      getDataFromDatabase(database);

      emit(AppUpdateDatabaseState());

    }
    );
  }
  void deleteData(
      {

        required int id,

      }
      )async
  {
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id],).then((value)
    {
      getDataFromDatabase(database);

      emit(AppDeleteDatabaseState());

    }
    );
  }
  bool isBottomSheetShown=false;
  IconData fapIcon=Icons.edit;
  void ChangeBottomSheetState ({
    required bool isShow,
    required IconData icon,

})
  {
    isBottomSheetShown=isShow;
    fapIcon=icon;
    emit(AppChangeBottomSheetState());

  }
  bool isDark=false;
  //ThemeMode appMode=ThemeMode.light,
  void changeAppMode({bool? fromShard}) {
    if(fromShard!=null)
    {
      isDark=fromShard;
      emit(AppChangeModeState());
    }

    else
    {
      isDark = !isDark;
      CasheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());

      }
      );
    }

  }
}