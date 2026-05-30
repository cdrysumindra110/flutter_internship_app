import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme.dart';
import '../../domain/models/todo_task.dart';

class TaskStats extends StatelessWidget {
  final List<TodoTask> tasks;

  const TaskStats({super.key, required this.tasks});

  int get completed => tasks.where((t) => t.isCompleted).length;
  int get pending => tasks.length - completed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatItem(
              label: 'Completed',
              count: completed,
              color: Colors.green,
            ),
            _StatItem(label: 'Pending', count: pending, color: Colors.orange),
            _StatItem(
              label: 'Total',
              count: tasks.length,
              color: AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatItem({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade400
                : Colors.grey,
          ),
        ),
      ],
    );
  }
}
