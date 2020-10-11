import 'dart:convert';

class Todo {
  String text;
  bool done;
  Todo({
    this.text,
    this.done = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'done': done,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Todo(
      text: map['text'],
      done: map['done'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));
}
