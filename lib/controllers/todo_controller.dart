import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app_getx/models/todo_model.dart';

class TodoController extends GetxController {
  var todos = List<Todo>().obs;
  GetStorage getStorage = GetStorage();
  @override
  void onInit() {
    var storedTodos = getStorage.read<List>('todos');
    if (storedTodos != null && storedTodos.isNotEmpty) {
      todos.addAll(storedTodos.map((e) => Todo.fromMap(jsonDecode(e))).toList());
    }
    ever(todos, (_) {
      getStorage.write('todos', todos.toList());
    });
    super.onInit();
  }

  void clear() {
    getStorage.erase();
    todos.clear();
  }
}
