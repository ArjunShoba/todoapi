// To parse this JSON data, do
//
//     final todomodel = todomodelFromJson(jsonString);

import 'dart:convert';

Todomodel todomodelFromJson(String str) => Todomodel.fromJson(json.decode(str));



class Todomodel {
    List<Todo> todos;

    Todomodel({
        required this.todos,
    });

    factory Todomodel.fromJson(Map<String, dynamic> json) => Todomodel(
        todos: List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x))),
    );

  
}

class Todo {
    int id;
    String todo;
    bool completed;

    Todo({
        required this.id,
        required this.todo,
        required this.completed,
    });

    factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
    };
}
