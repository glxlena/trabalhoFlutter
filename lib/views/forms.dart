import 'package:flutter/material.dart';
import 'package:projeto_flutter/models/task_model.dart';
import 'package:projeto_flutter/services/task_services.dart';

class FormsTasks extends StatefulWidget {
  final Task? task;
  final int? index;

  const FormsTasks({super.key, this.task, this.index});

  @override
  State<FormsTasks> createState() => _FormsTasksState();
}

class _FormsTasksState extends State<FormsTasks> {
  final _formKey=GlobalKey<FormState>();
  final TaskServices taskService = TaskServices();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String _priority = 'Baixa';

  @override
  void initState() {
    if(widget.task != null){
      _titleController.text = widget.task!.title!;
      _descriptionController.text = widget.task!.description!;
      _priority = widget.task!.priority ?? 'Baixa';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task != null ? 'Editar Tarefa' : 'Nova Tarefa')),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10),
              child:  TextFormField(
                controller: _titleController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Título não preenchido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Título da tarefa'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              ),
              Padding(padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                  label: Text('Descrição da tarefa'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Prioridade:'
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'Baixa',
                          groupValue: _priority,
                          onChanged: (value) {
                            setState(() {
                              _priority = value!;
                            });
                          },
                        ),
                        const Text('Baixa'),
                        Radio<String>(
                          value: 'Média',
                          groupValue: _priority,
                          onChanged: (value) {
                            setState(() {
                              _priority = value!;
                            });
                          },
                        ),
                        const Text('Média'),
                        Radio<String>(
                          value: 'Alta',
                          groupValue: _priority,
                          onChanged: (value) {
                            setState(() {
                              _priority = value!;
                            });
                          },
                        ),
                        const Text('Alta'),
                    ],
                    ),
                ],
                ),
              ),
              ElevatedButton(onPressed: ()async{
                if(_formKey.currentState!.validate()){
                  String title = _titleController.text;
                  String description = _descriptionController.text;
                  if(widget.task != null && widget.index != null){
                    await taskService.editTask(
                      widget.index!, title, description, widget.task!.isDone ?? false,
                      priority: _priority,
                    );
                  } else {
                    await taskService.saveTask(title, description, priority: _priority);
                  }
                }
                Navigator.pop(context);
              }, child: Text(widget.task != null ? 'Alterar Tarefa' : 'Salvar Tarefa'),)
            ],),
      ),
    );
  }
}