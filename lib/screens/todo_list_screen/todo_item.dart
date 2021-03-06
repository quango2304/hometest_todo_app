import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_item.dart';

class TodoItemWidget extends StatelessWidget {
  final Function onToggle;
  final Function onDelete;
  final TodoItem item;

  const TodoItemWidget({Key key, this.onToggle, this.item, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
          borderRadius: BorderRadius.circular(4)
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(item.isDone ? Icons.check_box : Icons.check_box_outline_blank, color: Colors.grey,),
            SizedBox(width: 10,),
            Expanded(
              child: Text(item.text),
            ),
            InkWell(onTap: onDelete, child: Icon(Icons.remove_circle, color: Colors.red,))
          ],
        ),
      ),
    );
  }
}
