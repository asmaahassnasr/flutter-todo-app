import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_aplication/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_aplication/modules/done_tasks/done_tasks_screen.dart';

import '../modules/new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex =0;
  List<Widget> screens= [NewTasksScreen(),DoneTasksScreen(),ArchivedTasksScreen()];

  List<String> screenTitle = ['New','Done','Archived'];

  @override
  void initState() {
    CreateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${screenTitle[currentIndex]} Tasks',
        ),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.task,
              ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline_outlined,
            ),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archived',
          ),
        ],
      ),

    );
  }

  void CreateDataBase() async
  {
    var dataBase =await openDatabase(
      'todoApp.db',
      version: 1,
      onCreate: (database,version) {
        print('Database  Created Successfully');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, status TEXT, date TEXT, time TEXT)')
            .then((value) => print('Table Created'))
            .catchError((err)=> print('Error is ${err.toString()}'));
      },
      onOpen: (database){
        print('Database opened');
      },
    );
  }
}
