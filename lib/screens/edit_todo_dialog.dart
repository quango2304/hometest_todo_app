import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_item.dart';


class EditTodoDialog extends StatefulWidget {
  final Function(TodoItem text) onSubmit;
  final TodoItem itemToEdit;
  const EditTodoDialog({Key key, this.onSubmit, this.itemToEdit}) : super(key: key);

  @override
  _EditTodoDialogState createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  final _textEditingController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.itemToEdit.text;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'input value'
              ),
              autofocus: true,
              onSubmitted: (text) {
                widget.onSubmit(TodoItem(
                  text: text
                ));
              },
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () {
                widget.onSubmit(TodoItem(
                    text: _textEditingController.text
                ));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  width: 100,
                  height: 40,
                  child: Center(child: Text("Update", style: TextStyle(
                    color: Colors.white
                  ),))),
            )
          ],
        ),
      ),
    );
  }
}
