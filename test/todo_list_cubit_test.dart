import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/models/todo_item.dart';
import 'package:todoapp/screens/todo_list_screen/cubit/todo_list_cubit.dart';

void main() {
  TodoListCubit todoListCubit;

  setUp(() {
    todoListCubit = TodoListCubit(
        state: TodoListInitial(todos: [TodoItem(text: '', isDone: false)]));
  });

  tearDown(() {
    todoListCubit.close();
  });


  blocTest<TodoListCubit, TodoListState>(
    'addItem',
    build: () {
      return todoListCubit;
    },
    act: (bloc) => bloc.addTodo(TodoItem(text: '', isDone: false)),
    expect: [isA<TodoListUpdateLoading>(), isA<TodoListUpdateSuccess>()],
  );

  blocTest<TodoListCubit, TodoListState>(
    'deleteItem',
    build: () {
      return todoListCubit;
    },
    act: (bloc) => bloc.deleteTodo(TodoItem(text: '', isDone: false)),
    expect: [isA<TodoListUpdateLoading>(), isA<TodoListUpdateSuccess>()],
  );

  blocTest<TodoListCubit, TodoListState>(
    'toggleItemState',
    build: () {
      return todoListCubit;
    },
    act: (bloc) => bloc.toggleItemState(TodoItem(text: '', isDone: false)),
    expect: [isA<TodoListUpdateLoading>(), isA<TodoListUpdateSuccess>()],
  );

  blocTest<TodoListCubit, TodoListState>(
    'editItem',
    build: () {
      return todoListCubit;
    },
    act: (bloc) => bloc.editTodo(oldItem: TodoItem(text: '', isDone: false), newItem: TodoItem(text: 'new', isDone: false)),
    expect: [isA<TodoListUpdateLoading>(), isA<TodoListUpdateSuccess>()],
  );

  blocTest<TodoListCubit, TodoListState>(
    'updateOrder',
    build: () {
      return todoListCubit;
    },
    act: (bloc) => bloc.updateOrder(0, 0),
    expect: [isA<TodoListUpdateLoading>(), isA<TodoListUpdateSuccess>()],
  );
}
