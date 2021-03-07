import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/constant.dart';
import 'package:todoapp/models/tab_type.dart';
import 'package:todoapp/models/todo_item.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit({TodoListState state})
      : super(state ?? TodoListInitial(todos: []));

  void addTodo(TodoItem item) {
    try {
      emit(TodoListUpdateLoading(todos: state.todos));
      emit(TodoListUpdateSuccess(todos: [item, ...state.todos]));
      saveCache();
    } catch (e) {
      emit(TodoListUpdateFailure(todos: state.todos, error: e.toString()));
      print(e);
    }
  }

  void deleteTodo(TodoItem item) {
    try {
      emit(TodoListUpdateLoading(todos: state.todos));
      final itemIndex = state.todos.indexOf(item);
      final newTodos = [...state.todos]..removeAt(itemIndex);
      emit(TodoListUpdateSuccess(todos: newTodos));
      saveCache();
    } catch (e) {
      emit(TodoListUpdateFailure(todos: state.todos, error: e.toString()));
      print(e);
    }
  }

  void editTodo({TodoItem oldItem, TodoItem newItem}) {
    try {
      emit(TodoListUpdateLoading(todos: state.todos));
      final itemIndex = state.todos.indexOf(oldItem);
      state.todos.replaceRange(itemIndex, itemIndex+1, [newItem]);
      emit(TodoListUpdateSuccess(todos: state.todos));
      saveCache();
    } catch (e) {
      emit(TodoListUpdateFailure(todos: state.todos, error: e.toString()));
      print(e);
    }
  }

  void toggleItemState(TodoItem item) {
    try {
      emit(TodoListUpdateLoading(todos: state.todos));
      final itemIndex = state.todos.indexOf(item);
      state.todos[itemIndex] = item.copyWith(isDone: !item.isDone);
      emit(TodoListUpdateSuccess(todos: state.todos));
      saveCache();
    } catch (e) {
      emit(TodoListUpdateFailure(todos: state.todos, error: e.toString()));
      print(e);
    }
  }

  void updateOrder(int oldIndex, int newIndex) {
    try {
      emit(TodoListUpdateLoading(todos: state.todos));
      final item = state.todos.removeAt(oldIndex);
      state.todos.insert(newIndex, item);
      emit(TodoListUpdateSuccess(todos: state.todos));
      saveCache();
    } catch (e) {
      emit(TodoListUpdateFailure(todos: state.todos, error: e.toString()));
      print(e);
    }
  }

  List<TodoItem> getTodosBaseOnTabType(TabType tabType) {
    final items = state.todos;
    switch (tabType) {
      case TabType.all:
        return items;
      case TabType.todo:
        return items.where((todo) {
          return !todo.isDone;
        }).toList();
      case TabType.done:
        return items.where((todo) {
          return todo.isDone;
        }).toList();
      default:
        return [];
    }
  }

  void saveCache() async {
    try {
      final pref = await SharedPreferences.getInstance();
      pref.setStringList(
          AppConstant.todoListPrefKey,
          state.todos.map((element) {
            return json.encode(element.toJson());
          }).toList());
    } catch (e) {
      print(e);
    }
  }

  void getCache() async {
    try {
      emit(TodoListUpdateLoading(todos: state.todos));
      final pref = await SharedPreferences.getInstance();
      final items = pref.getStringList(AppConstant.todoListPrefKey) ?? [];
      final todos = items.map((item) {
        return TodoItem.fromJson(json.decode(item));
      }).toList();
      emit(TodoListUpdateSuccess(todos: todos));
    } catch (e) {
      emit(TodoListUpdateFailure(todos: state.todos, error: e.toString()));
      print(e);
    }
  }
}
