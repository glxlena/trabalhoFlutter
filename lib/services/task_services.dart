import 'dart:convert';

import 'package:projeto_flutter/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskServices{
  Future<void> saveTask(String title, String description, {required String priority}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task newTask = Task(title: title, description: description, isDone: false, priority: priority);
    tasks.add(jsonEncode(newTask.toJson()));
    await prefs.setStringList('tasks', tasks);
  }

  getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = prefs.getStringList('tasks') ?? [];
    List<Task> tasks = taskStrings.map((taskJson) => Task.fromJson(jsonDecode(taskJson))).toList();
    return tasks;
  }

  editTask(int index, String newTitle, String newDescription, bool isDone, {String? priority}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task updateTask = Task(title: newTitle, description: newDescription, isDone: isDone, priority: priority);
    tasks[index] = jsonEncode(updateTask.toJson());
    await prefs.setStringList('tasks', tasks);
    }

deleteTask(int index) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> tasks = prefs.getStringList('tasks') ?? [];
  tasks.removeAt(index);
  await prefs.setStringList('tasks', tasks);
}
}