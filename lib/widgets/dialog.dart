import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/services/user_service.dart';
import 'package:todo_list/widgets/snackbar.dart';

class DialogContainer extends StatelessWidget {
  DialogContainer({
    required this.todoTitle,
    Key? key,
  }) : super(key: key);
  TextEditingController todoTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Add your task here',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            TextField(controller: todoTitle),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: (() async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (todoTitle.text.isEmpty) {
                        showSnackBar(context, 'Pls enter Todo first');
                      } else {
                        String username = await context
                            .read<UserService>()
                            .currentUser
                            .username;
                        Todo todo = Todo(
                            username: username,
                            created: DateTime.now(),
                            title: todoTitle.text);

                        String result =
                            await context.read<TodoService>().createTodo(todo);
                        if (result != 'OK') {
                          showSnackBar(context, result);
                        } else {
                          showSnackBar(context, 'Successfully added');
                          Navigator.pop(context);
                        }
                      }
                    }),
                    child: const Text('Add Task')),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  child: const Text('Cancel'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
