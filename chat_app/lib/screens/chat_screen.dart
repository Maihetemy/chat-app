import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bar.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = 'ChatScreen';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollections);
  TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kAtTime, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(
                Message.formjson(snapshot.data!.docs[i]),
              );
            }
            // print(messageList[0]);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                title: const AppChatBar(),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          chatMessage: messageList[index].message,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      controller: textEditingController,
                      onSubmitted: (data) {
                        messages.add(
                          {
                            kMessage: data,
                            kAtTime: DateTime.now(),
                            'email': email
                          },
                        );
                        textEditingController.clear();
                        scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn,
                        );
                      },
                      decoration: const InputDecoration(
                        hintText: 'Send message ',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Text('no data');
          }
        });
  }
}
