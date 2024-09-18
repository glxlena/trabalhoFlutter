import 'package:flutter/material.dart';
import 'package:projeto_flutter/models/task_model.dart';
import 'package:projeto_flutter/services/task_services.dart';
import 'package:projeto_flutter/views/forms.dart';

class ListViewTasks extends StatefulWidget {
  const ListViewTasks({super.key});

  @override
  State<ListViewTasks> createState() => _ListViewTasksState();
}

class _ListViewTasksState extends State<ListViewTasks> {
  TaskServices taskServices = TaskServices();
  List<Task> tasks = [];

  getAllTasks() async {
    tasks = await taskServices.getTasks();
    setState(() {});
  }

  @override
  void initState() {
    getAllTasks();
    super.initState();
  }

  Color getPriorityColor(String? priority) {
    switch (priority) {
      case 'Alta':
        return Colors.red;
      case 'Média':
        return Colors.orange;
      case 'Baixa':
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tarefas')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          bool localIsDone = tasks[index].isDone ?? false;
          return Column(
            children: [
              Card(
                color: const Color.fromARGB(255, 200, 200, 200),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tasks[index].title.toString(),
                            style: TextStyle(
                              color: localIsDone ? Colors.grey : Colors.green,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              decoration: localIsDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                                  decorationColor: Colors.red,
                            ),
                          ),
                          Checkbox(
                            value: tasks[index].isDone ?? false,
                            onChanged: (value) async {
                              if (value != null) {
                                await taskServices.editTask(
                                  index,
                                  tasks[index].title!,
                                  tasks[index].description!,
                                  value,
                                  priority: tasks[index].priority,
                                );
                                setState(() {
                                  tasks[index].isDone = value;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Text(
                        tasks[index].description.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Prioridade: ${tasks[index].priority}',
                            style: TextStyle(
                              color: getPriorityColor(tasks[index].priority),
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              if (!localIsDone)
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FormsTasks(
                                          task: tasks[index],
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: Colors.blue,
                                ),
                              IconButton(
                                onPressed: () async {
                                  await taskServices.deleteTask(index);
                                  getAllTasks(); // Atualizar a lista
                                },
                                icon: const Icon(Icons.delete),
                                color: localIsDone ? Colors.grey : Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
