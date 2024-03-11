import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.model.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  late bool isImportant;

  final formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    isImportant = widget.task.important;
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description ?? "";
  }

  saveTask() {
    if (!formKey.currentState!.validate()) return;

    final updatedTask = widget.task;

    updatedTask.important = isImportant;
    updatedTask.title = titleController.text;
    updatedTask.description =
        descriptionController.text.isEmpty ? null : descriptionController.text;

    Navigator.of(context).pop(updatedTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isImportant = !isImportant;
              });
            },
            icon: Icon(
              !isImportant ? Icons.star_border : Icons.star,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Título",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Descrição",
                ),
                maxLines: 5,
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: saveTask,
                child: const Text("Salar tarefa"),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Criada ${DateFormat.MMMEd("pt_BR").format(widget.task.createdAt)}",
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop("remover");
                    },
                    icon: const Icon(Icons.delete_outline),
                    iconSize: 28,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
