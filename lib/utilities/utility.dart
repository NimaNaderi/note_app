
import '../data/model/task_type.dart';
import '../data/model/type_enum.dart';

List<TaskType> getTaskTypeList() {
  return [
    TaskType(
        title: 'تمرکز',
        image: 'assets/images/meditate.png',
        taskTypeEnum: TaskTypeEnum.focus),
    TaskType(
        title: 'میتینگ',
        image: 'assets/images/social_frends.png',
        taskTypeEnum: TaskTypeEnum.date),
    TaskType(
        title: 'کار زیاد',
        image: 'assets/images/hard_working.png',
        taskTypeEnum: TaskTypeEnum.working),
        TaskType(
        title: 'ورزش',
        image: 'assets/images/workout.png',
        taskTypeEnum: TaskTypeEnum.workout),
  ];
}
