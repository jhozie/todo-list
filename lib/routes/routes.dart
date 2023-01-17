import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/pages/login.dart';
import 'package:todo_list/pages/register.dart';
import 'package:todo_list/pages/todo_list.dart';

class RouteManager {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: ((context) => Login()),
        );
      case register:
        return MaterialPageRoute(
          builder: ((context) => Register()),
        );
      case home:
        return MaterialPageRoute(
          builder: ((context) => TodoPage()),
        );
      default:
        throw Exception('Route page not set properly');
    }
  }
}
