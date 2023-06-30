import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

class Task extends StatefulWidget {
  final TaskModel model;

  Task({super.key, required this.model});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final dateFormat = DateFormat('dd/MM/y');

  void _removeTask(BuildContext context, {required TaskModel task}) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text(
            'Excluir tarefa',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Deseja excluir a tarefa (${task.description})?',
            style: const TextStyle(
              fontSize: 16,
              height: 1.2,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await context.read<HomeController>().removeById(task.id);

                if (!mounted) return;

                Navigator.of(context).pop();
              },
              child: const Text(
                'SIM',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'NÃO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            value: widget.model.finished,
            onChanged: (value) =>
                context.read<HomeController>().chechOrUncheckTask(widget.model),
          ),
          title: Text(
            widget.model.description,
            style: TextStyle(
              decoration:
                  widget.model.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            dateFormat.format(widget.model.dateTime),
            style: TextStyle(
              decoration:
                  widget.model.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1),
          ),
          trailing: IconButton(
            onPressed: () => _removeTask(context, task: widget.model),
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
