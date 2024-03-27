part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class FetchTodos extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;

  const AddTodoEvent({required this.title});

  @override
  List<Object> get props => [title];
}

class UpdateTodoEvent extends TodoEvent {
  final int id;
  final bool completed;

  const UpdateTodoEvent({required this.id, required this.completed});

  @override
  List<Object> get props => [id, completed];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;

  const DeleteTodoEvent({required this.id});

  @override
  List<Object> get props => [id];
}
