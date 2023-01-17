import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/user.dart';
import 'package:todo_list/routes/routes.dart';
import 'package:todo_list/services/user_service.dart';
import 'package:todo_list/widgets/body_text.dart';

import '../services/todo_service.dart';
import '../widgets/snackbar.dart';
import '../widgets/textfield.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController usernamee;
  late TextEditingController password;
  late TextEditingController email;

  @override
  void initState() {
    super.initState();
    usernamee = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernamee.dispose();
    password.dispose();
    email.dispose();
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
                  'Sign Up For Free',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Focus(
                  onFocusChange: ((value) async {
                    if (!value) {
                      String result = await context
                          .read<UserService>()
                          .checkIfUsersExist(usernamee.text.trim());
                      if (result == 'OK') {
                        context.read<UserService>().userExist = true;
                      } else {
                        context.read<UserService>().userExist = false;
                        if (!result
                            .contains('Username not found. Register now')) {
                          showSnackBar(context, result);
                        }
                      }
                    }
                  }),
                  child: MyAppTextField(
                    usernameController: usernamee,
                    text: 'Username',
                  ),
                ),
                Selector<UserService, bool>(
                  selector: (context, value) => value.userExist,
                  builder: (context, value, child) {
                    if (usernamee.text.trim().isEmpty) {
                      return Container();
                    } else {
                      return value
                          ? const Text(
                              'Username already exist, choose another one')
                          : Container();
                    }
                  },
                ),
                const SizedBox(height: 10),
                Focus(
                  onFocusChange: ((value) async {
                    if (!value) {
                      String result = await context
                          .read<UserService>()
                          .checkifEmailExist(email.text.trim());
                      if (result == 'OK') {
                        context.read<UserService>().emailExist = true;
                      } else {
                        context.read<UserService>().emailExist = false;
                        if (!result.contains('Email not found')) {
                          showSnackBar(context, result);
                        }
                      }
                    }
                  }),
                  child: EmailTextField(
                    text: 'Email',
                    emailController: email,
                  ),
                ),
                Consumer<UserService>(builder: ((context, value, child) {
                  if (email.text.trim().isEmpty) {
                    return Container();
                  }
                  if ((!email.text.trim().contains('@')) ||
                      (!email.text.trim().contains('.'))) {
                    return Text('invalid email format');
                  } else {
                    return value.emailExist
                        ? Text('Email already used. Choose another one')
                        : Container();
                  }
                })),
                const SizedBox(height: 10),
                MyPasswordTextField(
                  text: 'Password',
                  passwordController: password,
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
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    String result = await context
                        .read<UserService>()
                        .exceptionEmailUser(
                            email.text.trim(), usernamee.text.trim());
                    if (result == 'OK') {
                      return showSnackBar(
                          context, 'Username and Email already exist');
                    }
                    if (usernamee.text.isEmpty ||
                        password.text.isEmpty ||
                        email.text.isEmpty) {
                      showSnackBar(context, 'Pls add all fields');
                    } else {
                      User user = User(
                        username: usernamee.text.trim(),
                        email: email.text.trim(),
                        password: password.text.trim(),
                      );

                      String result =
                          await context.read<UserService>().createUser(user);
                      if (result != 'OK') {
                        showSnackBar(context, 'Pls complete registration');
                      } else {
                        String username =
                            context.read<UserService>().currentUser.username;
                        context.read<TodoService>().getTodos(username);
                        showSnackBar(context,
                            'You have successfully created an account');
                        Navigator.of(context).pushNamed(RouteManager.home);
                      }
                    }
                  },
                  child: BodyText(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      text: 'Sign Up'),
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
                        text: 'Already have an account yet?'),
                    TextButton(
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        child: BodyText(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            text: 'Log In'))
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
