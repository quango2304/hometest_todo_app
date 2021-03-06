import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  final Function(String text) onSubmit;

  const AddTodoDialog({Key key, this.onSubmit}) : super(key: key);

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _textEditingController = TextEditingController();

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
                widget.onSubmit(text);
              },
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () {
                widget.onSubmit(_textEditingController.text);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  width: 100,
                  height: 40,
                  child: Center(child: Text("Add", style: TextStyle(
                    color: Colors.white
                  ),))),
            )
          ],
        ),
      ),
    );
  }
}
