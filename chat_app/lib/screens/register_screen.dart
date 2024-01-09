import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/longin_screen.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/link_line.dart';
import 'package:chat_app/widgets/show_snack.dart';
import 'package:chat_app/widgets/submit_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, required this.nameScreen, required this.linkLine})
      : super(key: key);
  static String id = 'RegisterScreen';
  final String nameScreen, linkLine;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: Padding(
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
                  contant: 'Password',
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 16,
                ),
                SubmitButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, ChatScreen.id, arguments: email);
                        showSnack(context, 'Success!');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnack(context, 'Weak password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnack(context, 'Email already in use');
                        }
                      }
                    } else {
                      showSnack(context, 'Something is wrong !');
                    }
                    setState(() {
                      isLoading = false;
                    });
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
                    Navigator.pushNamed(context, LoginScreen.id);
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

  Future<void> registerUser() async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}


