import 'package:flutter/material.dart';
import 'package:todoapps/utils/my_btns.dart';

class DialogBox extends StatelessWidget {
  final inputController;
  VoidCallback onSave;
  VoidCallback onCcancle;
  DialogBox({
    super.key,
    required this.inputController,
    required this.onSave,
    required this.onCcancle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: Theme.of(context).primaryColor,
      content: Container(
        height: 120,
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // text field
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.black87,
                  ),
                ),
                hintText: 'Task name',
                //labelText: 'Task name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors
                          .black), // Change this color to your desired color
                ),
              ),
            ),

            // btns
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyBtns(
                  onPressed: onSave,
                  text: 'Save',
                ),
                SizedBox(
                  width: 10,
                ),
                MyBtns(
                  onPressed: onCcancle,
                  text: 'Cancle',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
