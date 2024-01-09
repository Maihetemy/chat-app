import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class AppChatBar extends StatelessWidget {
  const AppChatBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 70,
            ),
            const SizedBox(
              width: 6,
            ),
            const Text(
              'chat',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
          ],
        );
  }
}