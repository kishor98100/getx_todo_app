import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/todo_controller.dart';
import '../models/todo_model.dart';
import 'todo_screen.dart';

class HomeScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Getx Todo App'),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              todoController.clear();
            },
            child: Text('Clear'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map res = await Get.to(TodoScreen());
          if (!res.isNull) {
            Get.showSnackbar(
              GetBar(
                title: '${res['title']}',
                message: '${res['message']}',
              ),
            );
            Future.delayed(Duration(seconds: 2), () {
              if (Get.isSnackbarOpen) {
                Get.back();
              }
            });
          }
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Obx(
          () => ListView.separated(
            itemBuilder: (context, index) {
              Todo todo = todoController.todos[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    var removed = todo;
                    todoController.todos.remove(todo);
                    Get.showSnackbar(
                      GetBar(
                        title: 'Remove Todo',
                        message: 'You Removed ${todo.text} From Todo List',
                        mainButton: FlatButton(
                          onPressed: () {
                            if (!removed.isNull) {
                              todoController.todos.insert(index, removed);
                              removed = null;
                              if (Get.isSnackbarOpen) {
                                Get.back();
                              }
                            } else {
                              Get.back();
                            }
                          },
                          child: Text('Undo'),
                        ),
                      ),
                    );
                    Future.delayed(Duration(seconds: 3), () {
                      if (Get.isSnackbarOpen) {
                        Get.back();
                      }
                    });
                  }
                },
                child: ListTile(
                  title: Text(
                    todo.text,
                    style: TextStyle(
                      color: todo.done ? Colors.green : Colors.orange,
                      decoration: todo.done ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                  onTap: () {},
                  leading: Checkbox(
                    value: todo.done,
                    onChanged: (value) {
                      todo.done = value;
                      todoController.todos[index] = todo;
                    },
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      Map res = await Get.to(TodoScreen(
                        todo: todo,
                      ));
                      if (!res.isNull) {
                        Get.showSnackbar(
                          GetBar(
                            title: '${res['title']}',
                            message: '${res['message']}',
                          ),
                        );
                        Future.delayed(Duration(seconds: 2), () {
                          if (Get.isSnackbarOpen) {
                            Get.back();
                          }
                        });
                      }
                    },
                    icon: Icon(Icons.chevron_right),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: todoController.todos.length,
          ),
        ),
      ),
    );
  }
}
