import 'package:bloc_mastering/Pages/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/Todobloc/todo_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.cyan,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: context.watch<TodoBloc>().state.todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TodoDetail(index: index);
                  }));
                },
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: colors[index % colors.length],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                title: Text(
                  context.watch<TodoBloc>().state.todos[index].title,
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: context.watch<TodoBloc>().state.todos[index].completed
                    ? const Icon(Icons.check, color: Colors.green)
                    : const Icon(Icons.calendar_today_outlined,
                        color: Colors.green),
              );
            },
          ),
        ),
      ],
    );
  }
}
