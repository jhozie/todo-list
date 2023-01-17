import 'package:flutter/cupertino.dart';
import 'package:todo_list/database/todo_database.dart';
import 'package:todo_list/models/user.dart';
import 'package:flutter/material.dart';

class UserService with ChangeNotifier {
  late User _currentUser;
  bool _userExist = false;
  bool _obscure = true;
  late User _currentEmail;
  bool _emailExist = false;

  User get currentEmail => _currentEmail;
  User get currentUser => _currentUser;
  bool get userExist => _userExist;
  bool get emailExist => _emailExist;
  bool get obscure => _obscure;
  set userExist(bool value) {
    _userExist = value;
    notifyListeners();
  }

  set emailExist(bool value) {
    _emailExist = value;
    notifyListeners();
  }

  void obscure1() {
    _obscure = !_obscure;
    notifyListeners();
  }

  Future<String> getUser(String username) async {
    String result = 'OK';
    try {
      _currentUser = await TodoDataBase.instance.getUser(username);
      notifyListeners();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> checkIfUsersExist(String username) async {
    String result = 'OK';
    try {
      await TodoDataBase.instance.getUser(username);
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> checkifEmailExist(String email) async {
    String result = 'OK';
    try {
      await TodoDataBase.instance.getEmail(email);
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> getUserEmail(String email) async {
    String result = 'OK';
    try {
      _currentEmail = await TodoDataBase.instance.getEmail(email);
      notifyListeners();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
    
  }

  Future<String> exceptionEmailUser(String email, String username) async {
    String result2 = 'OK';
    try {
      await TodoDataBase.instance.getEmail(email);
      await TodoDataBase.instance.getUser(username);
    } catch (e) {
      result2 = getHumanReadableError(e.toString());
    }
    return result2;
  }

  Future<String> createUser(User user) async {
    String result = 'OK';
    notifyListeners();
    try {
      _currentUser = await TodoDataBase.instance.createUser(user);
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  String getHumanReadableError(String message) {
    if (message.contains('UNIQUE')) {
      return 'This user already exists in the database. Please choose a new one.';
    }
    if (message.contains('not found in the database.')) {
      return 'Username not found. Register now';
    }
    if (message.contains('wasn\'t found')) {
      return 'Email not found';
    }

    return message;
  }
}
