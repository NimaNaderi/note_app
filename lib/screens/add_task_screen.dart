import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:todo/utilities/utility.dart';
import 'package:todo/widgets/task_type_item.dart';

import '../data/model/task.dart';


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

  DateTime? _time;

  int _selectTaskTypeItem = 0;

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
        child: Container(
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
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomHourPicker(
                    title: 'زمان تسک را انتخاب کن',
                    negativeButtonText: 'حذف کن',
                    positiveButtonText: 'انتخاب زمان',
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
                      setState(() {
                        _time = time;
                      });
                    },
                    onNegativePressed: (context) {
                      setState(() {
                        _time = null;
                      });
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
                          selectedListItem: _selectTaskTypeItem,
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
                    if (taskTitleController.value.text.length == 0 &&
                        taskSubTitleController.value.text.length == 0) {
                      MotionToast.error(
                        description:
                            Text('! عنوان یا توضیحات تسک نباید خالی باشه'),
                        barrierColor: Colors.red.withOpacity(.2),
                      ).show(context);
                      return;
                    }
                    var taskTitle = taskTitleController.text;
                    var taskSubTitle = taskSubTitleController.text;
                    addTask(taskTitle, taskSubTitle);
                    Navigator.of(context).pop('َAdded');
                  },
                  child: Text(
                    _time == null
                        ? 'لطفا زمان تسک را انتخاب کنید'
                        : 'اضافه کردن تسک',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTask(String taskTitle, String taskSubTitle) {
    var task = Task(
        title: taskTitle,
        subTitle: taskSubTitle,
        time: _time!,
        taskType: getTaskTypeList()[_selectTaskTypeItem]);
    taskBox.add(task);
  }
}
