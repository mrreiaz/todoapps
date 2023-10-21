import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTail extends StatefulWidget {
  @override
  final String taskName;

  final bool taskCompletd;

  Function(bool?)? onChange;
  Function(BuildContext)? editTask;
  Function(BuildContext)? deleteTask;

  ToDoTail({
    super.key,
    required this.taskName,
    required this.onChange,
    required this.taskCompletd,
    required this.editTask,
    required this.deleteTask,
  });

  @override
  State<ToDoTail> createState() => _ToDoTailState();
}

class _ToDoTailState extends State<ToDoTail> {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.editTask,
              icon: Icons.edit,
              backgroundColor: Colors.greenAccent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            SlidableAction(
              onPressed: widget.deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              // check box
              Checkbox(
                value: widget.taskCompletd,
                onChanged: widget.onChange,
                checkColor: Colors.white,
                activeColor: Colors.black,
              ),
              // Task name
              Text(
                widget.taskName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: widget.taskCompletd
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
