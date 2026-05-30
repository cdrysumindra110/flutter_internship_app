part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TodoEvent {}

class AddTask extends TodoEvent {
  final String title;
  final TaskCategory category;
  final String? description;
  final DateTime? dueDate;

  const AddTask({
    required this.title,
    required this.category,
    this.description,
    this.dueDate,
  });

  @override
  List<Object?> get props => [title, category];
}

class EditTask extends TodoEvent {
  final String id;
  final String newTitle;
  final TaskCategory newCategory;
  final String? newDescription;
  final DateTime? newDueDate;

  const EditTask({
    required this.id,
    required this.newTitle,
    required this.newCategory,
    this.newDescription,
    this.newDueDate,
  });

  @override
  List<Object?> get props => [
    id,
    newTitle,
    newCategory,
    newDescription,
    newDueDate,
  ];
}

class DeleteTask extends TodoEvent {
  final String id;

  const DeleteTask(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleTaskCompletion extends TodoEvent {
  final String id;

  const ToggleTaskCompletion(this.id);

  @override
  List<Object?> get props => [id];
}
