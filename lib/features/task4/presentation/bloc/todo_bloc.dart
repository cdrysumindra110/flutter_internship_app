import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/todo_task.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  static const String _storageKey = 'todo_tasks';
  final SharedPreferences prefs;
  final Uuid uuid = const Uuid();

  TodoBloc({required this.prefs}) : super(const TodoState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<EditTask>(_onEditTask);
    on<DeleteTask>(_onDeleteTask);
    on<ToggleTaskCompletion>(_onToggleTaskCompletion);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TodoState> emit) async {
    final String? tasksJson = prefs.getString(_storageKey);
    if (tasksJson != null) {
      final tasks = TodoTask.listFromJson(tasksJson);
      emit(state.copyWith(status: TodoStatus.loaded, tasks: tasks));
    } else {
      emit(state.copyWith(status: TodoStatus.loaded, tasks: const []));
    }
  }

  Future<void> _saveTasks(List<TodoTask> tasks) async {
    await prefs.setString(_storageKey, TodoTask.listToJson(tasks));
  }

  Future<void> _onAddTask(AddTask event, Emitter<TodoState> emit) async {
    final newTask = TodoTask(
      id: uuid.v4(),
      title: event.title,
      description: event.description,
      category: event.category,
      dueDate: event.dueDate,
    );
    final updatedTasks = [...state.tasks, newTask];
    emit(state.copyWith(tasks: updatedTasks));
    await _saveTasks(updatedTasks);
  }

  Future<void> _onEditTask(EditTask event, Emitter<TodoState> emit) async {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == event.id) {
        return task.copyWith(
          title: event.newTitle,
          category: event.newCategory,
          description: event.newDescription,
          dueDate: event.newDueDate,
        );
      }
      return task;
    }).toList();
    emit(state.copyWith(tasks: updatedTasks));
    await _saveTasks(updatedTasks);
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TodoState> emit) async {
    final updatedTasks = state.tasks
        .where((task) => task.id != event.id)
        .toList();
    emit(state.copyWith(tasks: updatedTasks));
    await _saveTasks(updatedTasks);
  }

  Future<void> _onToggleTaskCompletion(
    ToggleTaskCompletion event,
    Emitter<TodoState> emit,
  ) async {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == event.id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
    emit(state.copyWith(tasks: updatedTasks));
    await _saveTasks(updatedTasks);
  }
}
