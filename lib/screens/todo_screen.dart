import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/todo_model.dart';
import '../widgets/Todo_list.dart';
import 'add_todo_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTodoScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<TodoModel> tasksList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Todo App"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [TodoList(taskList: tasksList)],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: "Add Todo",
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
