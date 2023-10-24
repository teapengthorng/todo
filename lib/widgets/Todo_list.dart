import 'package:flutter/material.dart';
import 'package:todo_list/blocs/bloc_exports.dart';

import '../constants/constants.dart';
import '../models/todo_model.dart';

class TodoList extends StatelessWidget {
  TodoList({
    super.key,
    required this.taskList,
  });

  final List<TodoModel> taskList;

  final TextEditingController _newTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          var task = taskList[index];
          return ListTile(
            title: Text(task.title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext cx) {
                            return StatefulBuilder(
                              builder: ((context, setState) {
                                return AlertDialog(
                                  title: const Text(
                                    'Update Todo',
                                    style: TextStyle(
                                        fontSize: 25,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('Title')),
                                      Flexible(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            isDense: true,
                                          ),
                                          maxLines: 1,
                                          controller: _newTitle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: Constants.customButtonStyle,
                                      onPressed: () {
                                        Navigator.pop(cx);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      style: Constants.customButtonStyle,
                                      onPressed: () {
                                        if (_newTitle.text.isNotEmpty) {
                                          context.read<TasksBloc>().add(
                                                UpdateTask(
                                                  task: TodoModel(
                                                    title: _newTitle.text,
                                                  ),
                                                ),
                                              );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor:
                                                Constants.primaryColor,
                                            duration: Duration(seconds: 1),
                                            content:
                                                Text('Todo details updated'),
                                          ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor: Colors.deepOrange,
                                            duration: Duration(seconds: 1),
                                            content: Text('Please input data'),
                                          ));
                                        }

                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                        if (_newTitle.text.isNotEmpty) {
                                          context
                                              .read<TasksBloc>()
                                              .add(DeleteTask(task: task));
                                        }
                                      },
                                      child: const Text('Update'),
                                    ),
                                  ],
                                );
                              }),
                            );
                          });
                    },
                    icon: const Icon(Icons.edit, color: Colors.blue,)),
                IconButton(
                    onPressed: () {
                       showDialog(
                          context: context,
                          builder: (BuildContext cx) {
                            return StatefulBuilder(
                              builder: ((context, setState) {
                                return AlertDialog(
                                  title: const Text(
                                    'Do you want to Delete',
                                    style: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  
                                  actions: [
                                    ElevatedButton(
                                      style: Constants.customButtonStyle,
                                      onPressed: () {
                                        Navigator.pop(cx);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      style: Constants.customButtonStyle,
                                      onPressed: () {
                                        context.read<TasksBloc>().add(DeleteTask(task: task));
                                        Navigator.pop(cx);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              }),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
