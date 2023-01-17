import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/services/user_service.dart';

class MyAppTextField extends StatelessWidget {
  MyAppTextField({
    required this.text,
    required this.usernameController,
    Key? key,
  }) : super(key: key);

  String text;
  TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40, left: 40),
      child: TextField(
          style: const TextStyle(color: Colors.white),
          controller: usernameController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
            filled: true,
            fillColor: Colors.black26,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: text,
            labelStyle: GoogleFonts.poppins(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          )),
    );
  }
}

class EmailTextField extends StatelessWidget {
  EmailTextField({
    required this.text,
    required this.emailController,
    Key? key,
  }) : super(key: key);

  String text;
  TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: TextField(
          style: const TextStyle(color: Colors.white),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
            filled: true,
            fillColor: Colors.black26,
            labelText: text,
            labelStyle: GoogleFonts.poppins(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          )),
    );
  }
}

class MyPasswordTextField extends StatelessWidget {
  MyPasswordTextField({
    required this.text,
    required this.passwordController,
    Key? key,
  }) : super(key: key);

  String text;
  TextEditingController passwordController;
  // bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40, left: 40),
      child: TextField(
        style: TextStyle(color: Colors.white),
        obscureText: context.watch<UserService>().obscure,
        controller: passwordController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
            filled: true,
            fillColor: Colors.black26,
            labelText: text,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: GoogleFonts.poppins(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: IconButton(
              onPressed: (() {
                context.read<UserService>().obscure1();
              }),
              icon: context.read<UserService>().obscure
                  ? const Icon(Icons.visibility_outlined)
                  : const Icon(Icons.visibility_off_outlined),
            )

            // suffixIcon: IconButton(
            //     onPressed: (() {
            //   setState(() {
            //     obscure = !widget.obscure;
            //   });
            // }),
            // icon: widget.obscure
            //     ? Icon(Icons.visibility_outlined)
            //     : Icon(Icons.visibility_off_outlined)),
            // IconButton(
            //   onPressed: (() {}),
            //   icon: const Icon(Icons.visibility_off_outlined),
            //   color: Colors.white70,
            //   constraints: const BoxConstraints(minWidth: 100),
            // ),
            ),
      ),
    );
  }
}
