import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/link_line.dart';
import 'package:chat_app/widgets/show_snack.dart';
import 'package:chat_app/widgets/submit_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, required this.nameScreen, required this.linkLine})
      : super(key: key);
  static String id = 'LoginScreen';
  final String nameScreen;
  final String linkLine;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        key: formkey,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.nameScreen,
                      style: const TextStyle(
                        fontSize: 20,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 16,
                ),
                CustomTextField(
                  onchanged: (data) {
                    email = data;
                  },
                  color: kPrimaryColor,
                  contant: 'Email',
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 16,
                ),
                CustomTextField(
                  onchanged: (data) {
                    password = data;
                  },
                  color: kPrimaryColor,
                  contant: 'Password',
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 16,
                ),
                SubmitButton(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await loginUser();

                        // ignore: use_build_context_synchronously
                        showSnack(context, 'Success');
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, ChatScreen.id, arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-credential') {
                          log(e.code);
                          // ignore: use_build_context_synchronously
                          showSnack(context, 'User not found');
                        } else if (e.code == 'wrong-password') {
                          // ignore: use_build_context_synchronously
                          showSnack(context, 'Wrong Password');
                        } else {
                          // ignore: use_build_context_synchronously
                          showSnack(context, 'Something is wrong!');
                        }
                      }
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      showSnack(context, 'Something is wrong!');
                    }
                  },
                  content: widget.nameScreen,
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                LinkLine(
                  link: widget.linkLine,
                  function: () {
                    Navigator.pop(context);
                  },
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
