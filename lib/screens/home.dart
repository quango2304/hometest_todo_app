import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/models/tab_type.dart';
import 'package:todoapp/models/todo_item.dart';
import 'package:todoapp/screens/add_todo_dialog.dart';
import 'package:todoapp/screens/todo_list_screen/cubit/todo_list_cubit.dart';
import 'package:todoapp/screens/todo_list_screen/todo_list_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  TodoListCubit _todoListCubit;
  final _tabTypes = [TabType.all, TabType.todo, TabType.done];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _todoListCubit = context.read<TodoListCubit>();
    _todoListCubit.getCache();
  }

  void showCreateTodoDialog() {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (_, __, ___) => AddTodoDialog(
              onSubmit: (text) {
                _todoListCubit.addTodo(TodoItem(isDone: false, text: text));
                Navigator.pop(context);
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListCubit, TodoListState>(builder: (_, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: showCreateTodoDialog,
          child: Icon(Icons.add),
        ),
        body: Center(
          child: TodoListScreen(
            items:
                _todoListCubit.getTodosBaseOnTabType(_tabTypes[_selectedIndex]),
            canReorder: _tabTypes[_selectedIndex] == TabType.all,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.border_all),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined),
              label: 'InComplete',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Complete',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onTabTapped,
        ),
      );
    });
  }
}
