import 'package:flutter/material.dart';

import '../data/model/task_type.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList(
      {Key? key,
      required this.taskType,
      required this.index,
      required this.selectedListItem})
      : super(key: key);

  TaskType taskType;
  int index;
  int selectedListItem;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: (selectedListItem == index) ? Color(0xff18DAA3) : Colors.white,
        border: Border.all(
            color:
                (selectedListItem == index) ? Color(0xff18DAA3) : Colors.grey,
            width: (selectedListItem == index) ? 0 : 2),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(8),
      width: 140,
      child: Column(
        children: [
          Image.asset(taskType.image),
          SizedBox(
            height: 6,
          ),
          Text(
            taskType.title,
            style: TextStyle(
                fontSize: (selectedListItem == index) ? 18 : 16,
                fontWeight: FontWeight.bold,
                color:
                    (selectedListItem == index) ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
