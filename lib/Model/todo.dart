import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String title;
  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  @override
  List<Object> get props => [id, title, completed];

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        completed = json['completed'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'completed': completed,
      };

  Todo copyWith({int? id, String? title, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
