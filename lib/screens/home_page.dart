import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/data.dart';
import '../utils/dialig_box.dart';
import '../utils/todo_tail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  // Hive.openBox('taskBox');
  final _myBox = Hive.box('taskBox');

  ToDoDatabase db = ToDoDatabase();
  // text controller
  final _controller = TextEditingController();
  var _editController = TextEditingController(text: "s");

  @override
  void initState() {
    // TODO: implement initState
    if (_myBox.get('TODOLIST') == null) {
      // if do data do something
      db.currentInitData();
    } else {
      // if already have data show it
      db.lodeData();
    }
    super.initState();
  }

  void checkBoxIsClicked(bool? value, int index) {
    //print(value);
    print(index);

    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          inputController: _controller,
          onSave: saveNewTask,
          onCcancle: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void editTask(int index) {
    // Create a TextEditingController for editing the task.
    _editController = TextEditingController(
      text: db.todoList[index][0],
    );

    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          inputController: _editController,
          onSave: () => updateTask(index),
          onCcancle: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewTask() {
    setState(() {
      db.todoList.insert(0, [_controller.text, false]);
      //db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateData();
    Navigator.of(context).pop();
  }

  void updateTask(index) {
    var editData = db.todoList.elementAt(index);
    db.todoList.removeAt(index);

    setState(() {
      if (editData[1] == false) {
        db.todoList.insert(index, [_editController.text, false]);
      } else {
        db.todoList.insert(index, [_editController.text, true]);
      }
      //db.todoList.removeAt(index);
    });
    db.updateData();
    Navigator.of(context).pop();
  }

  void deletTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
    //Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    //final reversedTodoList = List.from(db.todoList.reversed);
    final reversedTodoList = db.todoList;

    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        elevation: 0,
        title: Center(child: Text('ToDo')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            //alignment: Alignment.bottomRight,
            height: 700,
            child: ListView.builder(
              itemCount: db.todoList.length,
              //reverse: true,
              itemBuilder: (context, index) {
                //print(reversedTodoList[index]);
                return ToDoTail(
                  taskName: reversedTodoList[index][0],
                  taskCompletd: reversedTodoList[index][1],
                  onChange: (value) => checkBoxIsClicked(value, index),
                  editTask: (value) => editTask(index),
                  deleteTask: (value) => deletTask(index),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
