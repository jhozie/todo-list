import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';
import '../services/todo_service.dart';

class MySearchBar extends StatelessWidget {
  MySearchBar({
    required this.todo,
    Key? key,
  }) : super(key: key);

  Todo todo;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: ((value) {
        context.read<TodoService>().searchTodo1(todo.title);
      }),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
          filled: true,
          fillColor: Colors.white,
          hintText: 'e.g UI/UX design',
          labelStyle: GoogleFonts.poppins(
            color: Colors.black38,
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
          prefixIcon: const Icon(Icons.search_outlined)),
    );
  }
}
