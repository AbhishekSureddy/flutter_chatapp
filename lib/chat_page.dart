import 'dart:io';

import 'package:chatapp/widgets/chat_buble.dart';
import 'package:chatapp/widgets/chat_input.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final username;
  ChatPage({Key? key, required this.username}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage>  {

  List<String> _messages = [
    "Hi, it's Abhishek!",
    "Hi, it's Abhishek2!",
    "Hi, it's Abhishek3!",
    "Hi, it's Akshay!"
  ];
  List<File> _images = [
    File(""),
    File(""),
    File(""),
    File("")
  ];

  void onMessageSent(String message, File image) {
  _messages.add(message);
  _images.add(image);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Hi ${widget.username}!"),
        actions: [
          IconButton(onPressed: (){
            print("Icon Pressed");
            Navigator.pop(context);
          }, icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBuble(
                    alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
                    message: _messages[index],
                    image: _images[index]
                );
            }),
          ),
          ChatInput(onSubmit: onMessageSent,)
        ],
      ),
    );
  }
}
