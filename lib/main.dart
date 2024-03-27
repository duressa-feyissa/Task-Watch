import 'package:bloc_mastering/Bloc/Timerbloc/timer_bloc.dart';
import 'package:bloc_mastering/Bloc/Todobloc/todo_bloc.dart';
import 'package:bloc_mastering/widget/layout.dart';
import 'package:bloc_mastering/Model/ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => TodoBloc(),
      ),
      BlocProvider(
        create: (context) => TimerBloc(ticker: const Ticker()),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Layout(),
    ),
  ));
}
