import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/task.dart';
import 'package:todo/task_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();
  var taskBox = Hive.box<Task>('taskBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Center(
        child: ListView.builder(
          itemCount: taskBox.values.length,
          itemBuilder: (context, index) {
            var task = taskBox.values.toList()[index];
            return TaskWidget(task: task);
          },
        ),
      ),
      
    );
  }
}
