part of 'todo_list_cubit.dart';

abstract class TodoListState extends Equatable {
  final List<TodoItem> todos;
  const TodoListState({this.todos});
  @override
  List<Object> get props => [todos];
}

class TodoListInitial extends TodoListState {
  TodoListInitial({List<TodoItem> todos}): super(todos: todos);
}

class TodoListUpdateLoading extends TodoListState {
  TodoListUpdateLoading({List<TodoItem> todos}): super(todos: todos);
}

class TodoListUpdateSuccess extends TodoListState {
  TodoListUpdateSuccess({List<TodoItem> todos}): super(todos: todos);
}

class TodoListUpdateFailure extends TodoListState {
  final String error;
  TodoListUpdateFailure({List<TodoItem> todos, this.error}): super(todos: todos);
  @override
  List<Object> get props => [error, todos];
}
