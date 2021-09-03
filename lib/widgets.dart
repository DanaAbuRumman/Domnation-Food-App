import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFiled({
  required TextEditingController controller,
  required String label,
  bool? isPassword = false,
  required Function(String) function,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      cursorColor: Colors.black,
      obscureText: isPassword!,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        // labelStyle: TextStyle(color: Colors.deepOrangeAccent),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      validator: (value) {
        return function(value!);
      },
    ),
  );
}
