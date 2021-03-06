import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/screens/home.dart';
import 'package:todoapp/screens/todo_list_screen/cubit/todo_list_cubit.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<TodoListCubit>(
        create: (_) => TodoListCubit(),
        child: HomeScreen(),
      ),
    );
  }
}

