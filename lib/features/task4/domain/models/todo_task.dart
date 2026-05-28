import 'dart:convert';

enum TaskCategory { personal, study, work }

class TodoTask {
  final String id;
  final String title;
  final TaskCategory category;
  final bool isCompleted;
  final DateTime createdAt;

  TodoTask({
    required this.id,
    required this.title,
    required this.category,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  TodoTask copyWith({
    String? id,
    String? title,
    TaskCategory? category,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TodoTask(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category.name,
        'isCompleted': isCompleted,
        'createdAt': createdAt.toIso8601String(),
      };

  factory TodoTask.fromJson(Map<String, dynamic> json) => TodoTask(
        id: json['id'],
        title: json['title'],
        category: TaskCategory.values.byName(json['category']),
        isCompleted: json['isCompleted'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  static List<TodoTask> listFromJson(String jsonString) {
    final List<dynamic> data = json.decode(jsonString);
    return data.map((e) => TodoTask.fromJson(e)).toList();
  }

  static String listToJson(List<TodoTask> tasks) {
    return json.encode(tasks.map((e) => e.toJson()).toList());
  }
}