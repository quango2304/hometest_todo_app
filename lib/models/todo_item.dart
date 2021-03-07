import 'package:equatable/equatable.dart';

class TodoItem extends Equatable {
  TodoItem({
    this.text,
    this.isDone = false,
  });

  final String text;
  final bool isDone;

  TodoItem copyWith({
    String text,
    bool isDone,
  }) =>
      TodoItem(
        text: text ?? this.text,
        isDone: isDone ?? this.isDone,
      );

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
    text: json["text"] == null ? null : json["text"],
    isDone: json["isDone"] == null ? null : json["isDone"],
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "isDone": isDone == null ? null : isDone,
  };

  @override
  List<Object> get props => [text, isDone];
}
