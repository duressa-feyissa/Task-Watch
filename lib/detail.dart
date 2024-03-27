import 'package:bloc_mastering/Todobloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoDetail extends StatelessWidget {
  const TodoDetail({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _timController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('This is a detailed view of the todo:'),
            const SizedBox(height: 16),
            Text('Title: ${context.watch<TodoBloc>().state.todos[index].title}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            context.watch<TodoBloc>().state.todos[index].completed
                ? const Row(
                    children: [
                      Text('Status:', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Icon(Icons.check, color: Colors.green),
                    ],
                  )
                : const Row(
                    children: [
                      Text('Status: ', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Icon(Icons.calendar_today_outlined, color: Colors.green),
                    ],
                  ),
            const SizedBox(height: 80),
            if (!context.watch<TodoBloc>().state.todos[index].completed)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Set a to finish this todo:',
                      style: TextStyle(fontSize: 18,)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _timController,
                    decoration: const InputDecoration(
                      hintText: 'Time',
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Start'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
