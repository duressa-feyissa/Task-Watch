import 'package:bloc_mastering/Todobloc/todo_bloc.dart';
import 'package:bloc_mastering/add_todo.dart';
import 'package:bloc_mastering/home.dart';
import 'package:bloc_mastering/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(FetchTodos());
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const Home(),
      const Timer(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            label: 'Timer',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddTodo();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
