import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/controllers/todo_controller.dart';
import 'package:todo_app_getx/models/todo_model.dart';

class TodoScreen extends StatelessWidget {
  final Todo todo;
  final todoController = Get.find<TodoController>();
  final TextEditingController _textEditingController = TextEditingController();

  TodoScreen({Key key, this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _textEditingController.text = todo == null ? '' : todo.text;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  child: TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter Body',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 20.0,
                ),
                maxLines: 999,
                keyboardType: TextInputType.multiline,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () => Get.back(),
                    child: Text('Cancel'),
                  ),
                  RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      if (todo.isNull) {
                        todoController.todos.add(Todo(text: _textEditingController.text));
                      } else {
                        var index = todoController.todos.indexOf(todo);
                        todo.text = _textEditingController.text;
                        todoController.todos[index] = todo;
                      }
                      Get.back(
                        result: {
                          'title': todo.isNull ? 'Add Todo' : 'Edit Todo',
                          'message': todo.isNull ? 'Todo Added Successfully' : 'Todo Edited Successfully',
                        },
                      );
                    },
                    child: Text(todo.isNull ? 'Add' : 'Edit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
