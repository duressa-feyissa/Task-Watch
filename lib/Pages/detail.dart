import 'package:bloc_mastering/Bloc/Todobloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoDetail extends StatelessWidget {
  const TodoDetail({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<TodoBloc>().state.todos[index];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail'),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 16),
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              context.read<TodoBloc>().add(
                    DeleteTodoEvent(id: todo.id),
                  );
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This is a detailed view of the todo:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              'Title: ${todo.title}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Status: ',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                Icon(
                  todo.completed ? Icons.check : Icons.calendar_today_outlined,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  todo.completed ? 'Completed' : 'Pending',
                  style: TextStyle(
                    fontSize: 16,
                    color: todo.completed ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: todo.completed,
                  onChanged: (bool? newValue) {
                    context.read<TodoBloc>().add(
                          UpdateTodoEvent(
                            id: todo.id,
                            completed: newValue!,
                          ),
                        );
                  },
                  activeColor: Colors.green,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Mark as completed',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
