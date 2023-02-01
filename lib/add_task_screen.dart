import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskSubTitleController = TextEditingController();

  final taskBox = Hive.box<Task>('taskBox');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode1.addListener(() {
      setState(() {});
    });
    focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: taskTitleController,
                  focusNode: focusNode1,
                  decoration: InputDecoration(
                    labelText: 'عنوان تسک',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: focusNode1.hasFocus
                          ? Color(0xff18DAA3)
                          : Color(0xFFC5C5C5),
                    ),
                    contentPadding: EdgeInsets.all(16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Color(0xffC5C5C5),
                        width: 3.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Color(0xff18DAA3),
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: taskSubTitleController,
                  maxLines: 2,
                  focusNode: focusNode2,
                  decoration: InputDecoration(
                    labelText: 'عنوان تسک',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: focusNode2.hasFocus
                          ? Color(0xff18DAA3)
                          : Color(0xFFC5C5C5),
                    ),
                    contentPadding: EdgeInsets.all(16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Color(0xffC5C5C5),
                        width: 3.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Color(0xff18DAA3),
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff18DAA3),
                minimumSize: Size(200, 48),
              ),
              onPressed: () {
                var taskTitle = taskTitleController.text;
                var taskSubTitle = taskSubTitleController.text;
                addTask(taskTitle, taskSubTitle);
              },
              child: Text(
                'اضافه کردن تسک',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )),
      ),
    );
  }

  addTask(String taskTitle, String taskSubTitle) {
    var task = Task(title: taskTitle, subTitle: taskSubTitle);
    taskBox.add(task);
    print(taskBox.get(1)!.title);
  }
}
