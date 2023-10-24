import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/todo_model.dart';

// ignore: must_be_immutable
class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({
    super.key,
  });

  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Add Todo",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
                label: Text("Title"), border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")),
              BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isNotEmpty) {
                        var task = TodoModel(title: titleController.text);
                        context.read<TasksBloc>().add(AddTask(task: task));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          
                          duration: Duration(seconds: 1),
                          content: Text("Todo added successfully"),
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.deepOrange,
                          duration: Duration(seconds: 1),
                          content: Text("Please input data"),
                        ));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Add"));
              })
            ],
          ),
        ],
      ),
    );
  }
}
