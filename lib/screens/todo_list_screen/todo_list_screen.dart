import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/models/todo_item.dart';
import 'package:todoapp/screens/edit_todo_dialog.dart';
import 'package:todoapp/screens/todo_list_screen/cubit/todo_list_cubit.dart';
import 'package:todoapp/screens/todo_list_screen/todo_item.dart';

class TodoListScreen extends StatelessWidget {
  final List<TodoItem> items;
  final bool canReorder;

  const TodoListScreen({Key key, this.items, this.canReorder = false})
      : super(key: key);

  void _onToggle(BuildContext context, TodoItem item) {
    context
        .read<TodoListCubit>()
        .toggleItemState(item);
  }

  void _onDelete(BuildContext context, TodoItem item) {
    context.read<TodoListCubit>().deleteTodo(item);
  }

  void _onEdit(BuildContext context, TodoItem oldItem) {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (_, __, ___) => EditTodoDialog(
          itemToEdit: oldItem,
          onSubmit: (newTodo) {
            context.read<TodoListCubit>().editTodo(oldItem: oldItem, newItem: newTodo);
            Navigator.pop(context);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: canReorder
            ? Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              shadowColor: Colors.transparent,
            ),
              child: ReorderableListView(
                  children: [
                    for (int i = 0; i < items.length; i++)
                      Container(
                        key: ValueKey(i),
                        margin: EdgeInsets.only(bottom: 4),
                        child: TodoItemWidget(
                          onToggle: () {
                            _onToggle(context, items[i]);
                          },
                          onDelete: () {
                            _onDelete(context, items[i]);
                          },
                          onEdit: () {
                            _onEdit(context, items[i]);
                          },
                          item: items[i],
                        ),
                      )
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    context.read<TodoListCubit>().updateOrder(oldIndex, newIndex);
                  },
                ),
            )
            : ListView.separated(
                itemBuilder: (_, i) => TodoItemWidget(
                  key: ValueKey(i),
                  onToggle: () {
                    _onToggle(context, items[i]);
                  },
                  onDelete: () {
                    _onDelete(context, items[i]);
                  },
                  onEdit: () {
                    _onEdit(context, items[i]);
                  },
                  item: items[i],
                ),
                itemCount: items.length,
                separatorBuilder: (_, __) => SizedBox(
                  height: 4,
                ),
              ));
  }
}
