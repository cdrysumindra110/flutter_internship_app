part of 'todo_bloc.dart';

enum TodoStatus { initial, loaded }

class TodoState extends Equatable {
  final TodoStatus status;
  final List<TodoTask> tasks;

  const TodoState({this.status = TodoStatus.initial, this.tasks = const []});

  TodoState copyWith({TodoStatus? status, List<TodoTask>? tasks}) {
    return TodoState(status: status ?? this.status, tasks: tasks ?? this.tasks);
  }

  @override
  List<Object?> get props => [status, tasks];
}
