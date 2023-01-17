import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/routes/routes.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => UserService())),
        ChangeNotifierProvider(create: ((context) => TodoService()))
      ],
      child: const MaterialApp(
        initialRoute: RouteManager.login,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}

