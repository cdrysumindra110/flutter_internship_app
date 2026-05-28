import 'package:flutter/material.dart';
import '../../domain/models/todo_task.dart';

class AddEditTaskDialog extends StatefulWidget {
  final TodoTask? task; // null for add, non-null for edit

  const AddEditTaskDialog({super.key, this.task});

  @override
  State<AddEditTaskDialog> createState() => _AddEditTaskDialogState();
}

class _AddEditTaskDialogState extends State<AddEditTaskDialog> {
  late TextEditingController _titleController;
  TaskCategory _selectedCategory = TaskCategory.personal;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
        text: widget.task?.title ?? '');
    if (widget.task != null) {
      _selectedCategory = widget.task!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task title',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TaskCategory>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              items: TaskCategory.values.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat.name[0].toUpperCase() + cat.name.substring(1)),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedCategory = val;
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.trim().isEmpty) return;
            Navigator.pop(context, {
              'title': _titleController.text.trim(),
              'category': _selectedCategory,
            });
          },
          child: Text(widget.task == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}