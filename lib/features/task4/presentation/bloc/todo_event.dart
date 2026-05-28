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

  const AddTask({required this.title, required this.category});

  @override
  List<Object?> get props => [title, category];
}

class EditTask extends TodoEvent {
  final String id;
  final String newTitle;
  final TaskCategory newCategory;

  const EditTask({
    required this.id,
    required this.newTitle,
    required this.newCategory,
  });

  @override
  List<Object?> get props => [id, newTitle, newCategory];
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