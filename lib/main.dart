import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:todo/screens/home_screen.dart';

import 'data/model/task.dart';
import 'data/model/task_type.dart';
import 'data/model/type_enum.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(const MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [NavigationHistoryObserver()],
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
