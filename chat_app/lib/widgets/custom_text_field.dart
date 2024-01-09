import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.contant,
    required this.onchanged,
    required this.color,
  });
  final String contant;
  Function(String) onchanged;
  Color color;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Feild is required!';
        }
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        label: Text(contant),
        labelStyle:  TextStyle(
          color: color,
          fontSize: 18,
        ),
        hintText: 'Your $contant',
        hintStyle:  TextStyle(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.w100,
        ),
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
      ),
    );
  }
}
