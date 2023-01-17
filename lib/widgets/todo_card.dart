import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/widgets/snackbar.dart';

import '../models/todo.dart';

class TodoCard extends StatelessWidget {
  TodoCard({
    required this.todo,
    Key? key,
  }) : super(key: key);

  Todo todo;
  

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const DrawerMotion(), children: [
        SlidableAction(
          backgroundColor: Color.fromARGB(255, 0, 136, 214),
          label: 'Delete',
          icon: Icons.delete,
          onPressed: ((context) async {
            String result = await context.read<TodoService>().deleteTodo(todo);
            if (result != 'OK') {
              showSnackBar(context, result);
            }
          }),
        ),
      ]),
      child: CheckboxListTile(
        activeColor: Color.fromRGBO(75, 94, 252, 1),
        side: BorderSide(width: 1),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // checkboxShape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        tileColor: Colors.white,
        title: Text(
          todo.title,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black54,
              decoration:
                  todo.done ? TextDecoration.lineThrough : TextDecoration.none),
        ),
        value: todo.done,
        onChanged: ((value) async {
          String result =
              await context.read<TodoService>().toggleTodoDone(todo);
          if (result != 'OK') {
            showSnackBar(context, result);
          }
        }),
        subtitle: Text(
          '${todo.created.day}/${todo.created.month}/${todo.created.year}',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
