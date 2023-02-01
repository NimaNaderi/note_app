import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/add_task_screen.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(const MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SM',
        textTheme: TextTheme(
          headline4: TextStyle(
            fontFamily: 'SM',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
