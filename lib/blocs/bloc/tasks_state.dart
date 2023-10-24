part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<TodoModel> allTasks;
  const TasksState({this.allTasks = const <TodoModel>[]});

  @override
  List<Object> get props => [allTasks];
}
