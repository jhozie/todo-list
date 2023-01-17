import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/routes/routes.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/services/user_service.dart';
import 'package:todo_list/widgets/body_text.dart';
import 'package:todo_list/widgets/snackbar.dart';

import '../widgets/textfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController username;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(75, 94, 252, 1),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login to Your Account',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Focus(
                  onFocusChange: ((value) async {
                    if (!value) {
                      String result = await context
                          .read<UserService>()
                          .checkIfUsersExist(username.text.trim());
                      if (result == 'OK') {
                        context.read<UserService>().userExist = false;
                      } else {
                        context.read<UserService>().userExist = true;
                        if (!result
                            .contains('Username not found. Register now')) {
                          showSnackBar(context, result);
                        }
                      }
                    }
                  }),
                  child: MyAppTextField(
                    usernameController: username,
                    text: 'Username',
                  ),
                ),
                Consumer<UserService>(builder: ((context, value, child) {
                  if (username.text.trim().isEmpty) {
                    return Container();
                  } else {
                    return value.userExist
                        ? Text('Username does not exist')
                        : Container();
                  }
                })),
                const SizedBox(height: 10),
                MyPasswordTextField(
                  text: 'Password',
                  passwordController: password,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BodyText(
                          color: Colors.white70,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          text: 'Forgot Password?'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    minimumSize: const Size(330, 60),
                  ),
                  onPressed: (() async {
                    if (username.text.trim().isEmpty ||
                        password.text.trim().isEmpty) {
                      showSnackBar(context, 'Pls enter all fields');
                    } else {
                      String result = await context
                          .read<UserService>()
                          .getUser(username.text.trim());
                      if (result == 'OK') {
                        String username =
                            context.read<UserService>().currentUser.username;
                        context.read<TodoService>().getTodos(username);
                        showSnackBar(context, 'Login Successfull');
                        Navigator.of(context).pushNamed(RouteManager.home);
                      } else {
                        showSnackBar(context, result);
                      }
                    }
                  }),
                  child: BodyText(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      text: 'Log In'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    BodyText(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        text: 'Don\'t gave an account yet?'),
                    TextButton(
                        onPressed: (() {
                          Navigator.of(context)
                              .pushNamed(RouteManager.register);
                        }),
                        child: BodyText(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            text: 'Sign Up'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
