import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:todo/utilities/utility.dart';
import 'package:todo/widgets/task_type_item.dart';

import '../data/model/task.dart';
import 'add_task_screen.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  TextEditingController? taskTitleController;
  TextEditingController? taskSubTitleController;

  final taskBox = Hive.box<Task>('taskBox');

  bool? isDone;

  DateTime? _time;

  int? _selectTaskTypeItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _time = widget.task.time;

    taskTitleController = TextEditingController(text: widget.task.title);
    taskSubTitleController = TextEditingController(text: widget.task.subTitle);
    isDone = widget.task.isDone;
    _selectTaskTypeItem = getTaskTypeList().indexWhere((taskType) =>
        taskType.taskTypeEnum == widget.task.taskType.taskTypeEnum);

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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
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
                        labelText: 'توضیحات تسک',
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
                SizedBox(
                  height: 30,
                ),
                AnimatedToggleSwitch<bool>.dual(
                  first: true,
                  second: false,
                  current: isDone!,
                  iconBuilder: (value) {
                    if (isDone!) {
                      return Container(
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 24,
                        ),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xff18DAA3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      );
                    } else
                      return Container(
                        child: Icon(
                          Icons.history,
                          color: Colors.white,
                          size: 24,
                        ),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xff18DAA3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      );
                  },
                  indicatorSize: Size.fromWidth(50),
                  borderColor: Color(0xff18DAA3),
                  borderWidth: 3,
                  colorBuilder: (value) => Colors.white,
                  onChanged: (p0) {
                    setState(() {
                      isDone = p0;
                    });
                  },
                  animationDuration: Duration(milliseconds: 500),
                  animationCurve: Curves.easeInOut,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomHourPicker(
                    date: _time,
                    title: 'زمان تسک را تغییر دهید',
                    negativeButtonText: 'زمان پیشفرض',
                    positiveButtonText: 'تغییر زمان',
                    elevation: 2,
                    titleStyle: TextStyle(
                        color: Color(0xff18DAA3),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    positiveButtonStyle: TextStyle(
                        color: Color(0xff18DAA3),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    negativeButtonStyle: TextStyle(
                        color: Color.fromARGB(255, 218, 66, 24),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    onPositivePressed: (context, time) {
                      _time = time;
                    },
                    onNegativePressed: (context) {
                      _time = widget.task.time;
                    },
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getTaskTypeList().length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectTaskTypeItem = index;
                          });
                        },
                        child: TaskTypeItemList(
                          taskType: getTaskTypeList()[index],
                          index: index,
                          selectedListItem: _selectTaskTypeItem!,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff18DAA3),
                    minimumSize: Size(200, 48),
                  ),
                  onPressed: () {
                    var taskTitle = taskTitleController!.text;
                    var taskSubTitle = taskSubTitleController!.text;
                    editTask(taskTitle, taskSubTitle);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'ویرایش کردن تسک',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  editTask(String taskTitle, String taskSubTitle) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;
    widget.task.isDone = isDone!;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectTaskTypeItem!];
    widget.task.save();
  }
}
