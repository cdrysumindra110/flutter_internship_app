import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/todo_task.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/add_edit_task_dialog.dart';
import '../widgets/task_card.dart';
import '../widgets/task_stats.dart';
import '../../../../shared/widgets/empty_state.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return BlocProvider(
          create: (_) {
            final bloc = TodoBloc(prefs: snapshot.data!);
            bloc.add(LoadTasks());
            return bloc;
          },
          child: Builder(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('To-Do List'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _showAddDialog(context),
                child: const Icon(Icons.add),
              ),
              body: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state.tasks.isEmpty) {
                    return const EmptyState(
                      message: 'No tasks yet.\nTap + to add one!',
                      icon: Icons.task_alt,
                    );
                  }
                  return Column(
                    children: [
                      TaskStats(tasks: state.tasks),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            final task = state.tasks[index];
                            return TaskCard(
                              task: task,
                              onToggle: () => context
                                  .read<TodoBloc>()
                                  .add(ToggleTaskCompletion(task.id)),
                              onEdit: () => _showEditDialog(context, task),
                              onDelete: () {
                                context.read<TodoBloc>().add(DeleteTask(task.id));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        );
      },
    );
  }

  void _showAddDialog(BuildContext context) async {
    final bloc = context.read<TodoBloc>();
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const AddEditTaskDialog(),
    );
    if (result != null) {
      bloc.add(AddTask(
        title: result['title'],
        category: result['category'],
      ));
    }
  }

  void _showEditDialog(BuildContext context, TodoTask task) async {
    final bloc = context.read<TodoBloc>();
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => AddEditTaskDialog(task: task),
    );
    if (result != null) {
      bloc.add(EditTask(
        id: task.id,
        newTitle: result['title'],
        newCategory: result['category'],
      ));
    }
  }
}