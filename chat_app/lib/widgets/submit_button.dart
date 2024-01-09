import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubmitButton extends StatelessWidget {
  SubmitButton(
      {super.key,
      required this.content,
      required this.onTap,
      required this.color});
  final String content;
  VoidCallback? onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
            child: Text(
          content,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
