import 'package:bloc/bloc.dart';
import 'package:bloc_mastering/Model/todo.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<FetchTodos>(_onFetchTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  void _onFetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    emit(state.copyWith(listTodoStatus: ListTodoStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(listTodoStatus: ListTodoStatus.loaded));
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    emit(state.copyWith(listTodoStatus: ListTodoStatus.loading));
    Todo todo = Todo(
      id: state.todos.length + 1,
      title: event.title,
      completed: false,
    );
    emit(state.copyWith(
      listTodoStatus: ListTodoStatus.loaded,
      todos: [todo, ...state.todos],
    ));
  }

  void _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) {
    emit(state.copyWith(listTodoStatus: ListTodoStatus.loading));
    List<Todo> todos = state.todos.map((todo) {
      if (todo.id == event.id) {
        return todo.copyWith(completed: event.completed);
      }
      return todo;
    }).toList();
    emit(state.copyWith(
      listTodoStatus: ListTodoStatus.loaded,
      todos: todos,
    ));
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    emit(state.copyWith(listTodoStatus: ListTodoStatus.loading));
    List<Todo> todos =
        state.todos.where((todo) => todo.id != event.id).toList();
    emit(state.copyWith(
      listTodoStatus: ListTodoStatus.loaded,
      todos: todos,
    ));
  }
}
