import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_item.dart';

class TodoItemWidget extends StatelessWidget {
  final Function onToggle;
  final Function onDelete;
  final Function onEdit;
  final TodoItem item;

  const TodoItemWidget({Key key, this.onToggle, this.item, this.onDelete, this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
          borderRadius: BorderRadius.circular(4)
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          children: [
            Icon(item.isDone ? Icons.check_box : Icons.check_box_outline_blank, color: Colors.grey,),
            SizedBox(width: 10,),
            Expanded(
              child: Text(item.text),
            ),
            InkWell(onTap: onEdit, child: Icon(Icons.edit, color: Colors.blue,)),
            SizedBox(width: 4,),
            InkWell(onTap: onDelete, child: Icon(Icons.remove_circle, color: Colors.red,))
          ],
        ),
      ),
    );
  }
}
