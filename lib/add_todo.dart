import 'package:bloc_mastering/Todobloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Spice Up Your List',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  const Text('Add a new todo to your list',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                  const SizedBox(height: 64),
                  ElevatedButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(AddTodoEvent(
                              title: _titleController.text,
                            ));
                        _titleController.clear();
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: Center(
                              child: Text(
                            'Add Todo',
                          ))))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
