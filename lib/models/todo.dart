import 'package:flutter/cupertino.dart';

final todoTable = 'todo';

class TodoFields {
  static final String username = 'username';
  static final String created = 'created';
  static final String done = 'done';
  static final String title = 'title';

  static List<String> allFields = [username, created, done, title];
}

class Todo {
  Todo(
      {required this.username,
      required this.created,
      this.done = false,
      required this.title});
  final String username;
  final String title;
  bool done;
  final DateTime created;

  Map<String, Object?> toJson() {
    return {
      TodoFields.username: username,
      TodoFields.title: title,
      TodoFields.created: created.toIso8601String(),
      TodoFields.done: done ? 1 : 0
    };
  }

  static Todo fromJson(Map<String, Object?> json) {
    return Todo(
      username: json[TodoFields.username] as String,
      created: DateTime.parse(json[TodoFields.created] as String),
      title: json[TodoFields.title] as String,
      done: json[TodoFields.done] == 1 ? true : false,
    );
  }

  @override
  bool operator ==(covariant Todo other) {
    return (title.toUpperCase() == other.title.toUpperCase()) &&
        (username == other.username);
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(username, title);
}
