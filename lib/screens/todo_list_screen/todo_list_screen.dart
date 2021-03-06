import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/models/todo_item.dart';
import 'package:todoapp/screens/todo_list_screen/cubit/todo_list_cubit.dart';
import 'package:todoapp/screens/todo_list_screen/todo_item.dart';

class TodoListScreen extends StatelessWidget {
  final List<TodoItem> items;
  final bool canReorder;

  const TodoListScreen({Key key, this.items, this.canReorder = false})
      : super(key: key);

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
                            context
                                .read<TodoListCubit>()
                                .toggleItemState(items[i]);
                          },
                          onDelete: () {
                            context.read<TodoListCubit>().deleteTodo(items[i]);
                          },
                          item: items[i],
                        ),
                      )
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    print("$oldIndex $newIndex");
                    context.read<TodoListCubit>().updateOrder(oldIndex, newIndex);
                  },
                ),
            )
            : ListView.separated(
                itemBuilder: (_, index) => TodoItemWidget(
                  key: ValueKey(index),
                  onToggle: () {
                    context.read<TodoListCubit>().toggleItemState(items[index]);
                  },
                  onDelete: () {
                    context.read<TodoListCubit>().deleteTodo(items[index]);
                  },
                  item: items[index],
                ),
                itemCount: items.length,
                separatorBuilder: (_, __) => SizedBox(
                  height: 4,
                ),
              ));
  }
}
