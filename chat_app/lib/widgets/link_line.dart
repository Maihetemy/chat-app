import 'package:flutter/material.dart';

class LinkLine extends StatelessWidget {
  const LinkLine({super.key, required this.link, required this.function, required this.color});
  final String link;
  final VoidCallback function;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          'Already have an accont. ',
          style: TextStyle(
            color: color,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        GestureDetector(
          onTap: function,
          child: Text(
            link,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
