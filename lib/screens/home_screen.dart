import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:todo/widgets/task_widget.dart';

import '../data/model/task.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: ((context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notif) {
                  if (taskBox.values.last == 0) return true;

                  setState(() {
                    if (notif.direction == ScrollDirection.forward) {
                      isFabVisible = true;
                    } else if (notif.direction == ScrollDirection.reverse) {
                      isFabVisible = false;
                    }
                  });
                  return true;
                },
                child: ListView.builder(
                  itemCount: taskBox.values.length,
                  itemBuilder: (context, index) {
                    var task = taskBox.values.toList()[index];
                    return _getListItem(task);
                  },
                ),
              );
            })),
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: isFabVisible
            ? Visibility(
                // visible: isFabVisible,
                child: FloatingActionButton(
                  onPressed: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddTaskScreen(),
                      ),
                    );
                    if (result == 'َAdded') {
                      MotionToast.success(
                        description: Text('.تسک با موفقیت افزوده شد'),
                        toastDuration: Duration(milliseconds: 1500),
                        barrierColor: Color(0xff18DAA3).withOpacity(.1),
                      ).show(context);
                    }
                  },
                  backgroundColor: Color(0xff18DAA3),
                  child: Image.asset('assets/images/icon_add.png'),
                ),
              )
            : null,
      ),
    );
  }

  Widget _getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        MotionToast.delete(
          description: Text('.این تسک با موفقیت حذف شد'),
          barrierColor: Colors.red.withOpacity(.1),
          toastDuration: Duration(milliseconds: 2000),
        ).show(context);
        task.delete();
      },
      child: TaskWidget(task: task),
    );
  }
}
