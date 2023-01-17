import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/user.dart';
import 'package:todo_list/routes/routes.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/services/user_service.dart';
import 'package:todo_list/widgets/body_text.dart';
import 'package:todo_list/widgets/todo_card.dart';

import '../models/todo.dart';
import '../widgets/dialog.dart';
import '../widgets/mysearchbar.dart';
import '../widgets/snackbar.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late TextEditingController todoController;
  // late TextEditingController searchController;

  List<String> searchList = [TodoFields.title];
  @override
  void initState() {
    todoController = TextEditingController();
    // searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    todoController.dispose();
    // searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          MyFloatingActionButton(todoController: todoController),
      // backgroundColor: Color.fromRGBO(241, 242, 243, 1),
      body: Container(
        color: Color.fromRGBO(241, 242, 243, 1),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    Consumer<UserService>(builder: ((context, value, child) {
                      return BodyText(
                          color: Colors.black87,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          text: 'Hi ${value.currentUser.username}, ');
                    })),
                    const SizedBox(width: 180),

                    // IconButton(
                    //   onPressed: (() {}),
                    //   icon: const Icon(
                    //     Icons.add,
                    //     size: 40,
                    //     color: Colors.black26,
                    //   ),
                    // ),
                    IconButton(
                      onPressed: (() {
                        Navigator.of(context).pushNamed(RouteManager.login);
                      }),
                      icon: const Icon(
                        Icons.exit_to_app_rounded,
                        size: 40,
                        color: Colors.black26,
                      ),
                    ),
                    // const CircleAvatar(
                    //   radius: 30,
                    //   backgroundColor: Colors.blue,
                    //   child: CircleAvatar(
                    //     radius: 27,
                    //     backgroundImage: AssetImage('assets/images/m.jpg'),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 50),
                TextField(
                  // controller: searchController,
                  onChanged: ((value) {
                    context.read<TodoService>().searchTodo1(value);
                  }),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'e.g UI/UX design',
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      prefixIcon: const Icon(Icons.search_outlined)),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    BodyText(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        text: 'Today'),
                    const SizedBox(width: 5),
                    BodyText(
                      color: Colors.black38,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      text:
                          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Consumer<TodoService>(
                    builder: (context, value, child) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: value.searchTodo.length,
                        itemBuilder: (context, index) {
                          return TodoCard(
                            todo: value.searchTodo[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    Key? key,
    required this.todoController,
  }) : super(key: key);

  final TextEditingController todoController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 100,
      child: FloatingActionButton(
        backgroundColor: Color.fromRGBO(75, 94, 252, 1),
        onPressed: (() {
          showDialog(
              context: context,
              builder: ((context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.none,
                  child: Container(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Add your task here',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          TextField(controller: todoController),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(75, 94, 252, 1),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  onPressed: (() async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (todoController.text.isEmpty) {
                                      showSnackBar(
                                          context, 'Pls enter Todo first');
                                    } else {
                                      String username = context
                                          .read<UserService>()
                                          .currentUser
                                          .username;
                                      Todo todo = Todo(
                                          username: username,
                                          created: DateTime.now(),
                                          title: todoController.text);
                                      if (context
                                          .read<TodoService>()
                                          .todo
                                          .contains(todo)) {
                                        showSnackBar(context, 'Duplicate');
                                      } else {
                                        String result = await context
                                            .read<TodoService>()
                                            .createTodo(todo);
                                        todoController.text = '';
                                        if (result == 'OK') {
                                          showSnackBar(
                                              context, 'Successfully added');
                                          Navigator.pop(context);
                                        } else {
                                          showSnackBar(context, result);
                                        }
                                      }
                                    }
                                  }),
                                  child: const Text('Add Task')),
                              const SizedBox(width: 4),
                              TextButton(
                                onPressed: (() {
                                  Navigator.pop(context);
                                }),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Color.fromRGBO(75, 94, 252, 1)),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }));
        }),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
