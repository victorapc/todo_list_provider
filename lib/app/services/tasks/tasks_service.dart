import 'package:todo_list_provider/app/models/week_task_model.dart';

import '../../models/task_model.dart';

abstract class TasksService {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTaskModel> getWeek();
  Future<void> checkOrUncheckTask(TaskModel task);
  Future<void> removeById(int id);
  Future<void> removeAllTasks();
}
