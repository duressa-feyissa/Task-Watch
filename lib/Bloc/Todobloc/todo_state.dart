part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, loaded, error }

enum ListTodoStatus { initial, loading, loaded, error }

class TodoState extends Equatable {
  final TodoStatus status;
  final Todo? todo;
  final ListTodoStatus listTodoStatus;
  final List<Todo> todos;

  const TodoState({
    this.status = TodoStatus.initial,
    this.listTodoStatus = ListTodoStatus.initial,
    this.todo,
    this.todos = const [],
  });

  @override
  List<Object> get props => [
        status,
        listTodoStatus,
        todos,
      ];

  TodoState copyWith({
    TodoStatus? status,
    ListTodoStatus? listTodoStatus,
    Todo? todo,
    List<Todo>? todos,
  }) {
    return TodoState(
        status: status ?? this.status,
        listTodoStatus: listTodoStatus ?? this.listTodoStatus,
        todo: todo ?? this.todo,
        todos: todos ?? this.todos);
  }
}
