import 'package:hive/hive.dart';

class ToDoDatabase {
  List todoList = [];

  // refarnce our box.
  final _myBox = Hive.box('taskBox');
  // fist time open this apps show this data
  void currentInitData() {
    todoList = [];
  }

  // lode data
  void lodeData() {
    todoList = _myBox.get('TODOLIST');
  }

// update data
  void updateData() {
    _myBox.put('TODOLIST', todoList);
  }

// delete data
}
