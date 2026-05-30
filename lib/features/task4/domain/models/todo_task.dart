import 'dart:convert';

enum TaskCategory { personal, study, work }

class TodoTask {
  final String id;
  final String title;
  final String? description;
  final TaskCategory category;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? dueDate;

  TodoTask({
    required this.id,
    required this.title,
    this.description,
    required this.category,
    this.isCompleted = false,
    DateTime? createdAt,
    this.dueDate,
  }) : createdAt = createdAt ?? DateTime.now();

  TodoTask copyWith({
    String? id,
    String? title,
    String? description,
    TaskCategory? category,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
  }) {
    return TodoTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category.name,
    'isCompleted': isCompleted,
    'createdAt': createdAt.toIso8601String(),
    'dueDate': dueDate?.toIso8601String(),
  };

  factory TodoTask.fromJson(Map<String, dynamic> json) => TodoTask(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    category: TaskCategory.values.byName(json['category']),
    isCompleted: json['isCompleted'],
    createdAt: DateTime.parse(json['createdAt']),
    dueDate: json['dueDate'] == null ? null : DateTime.parse(json['dueDate']),
  );

  static List<TodoTask> listFromJson(String jsonString) {
    final List<dynamic> data = json.decode(jsonString);
    return data.map((e) => TodoTask.fromJson(e)).toList();
  }

  static String listToJson(List<TodoTask> tasks) {
    return json.encode(tasks.map((e) => e.toJson()).toList());
  }
}
