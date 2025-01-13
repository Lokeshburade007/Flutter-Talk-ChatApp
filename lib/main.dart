import 'package:chat_app/chatApp/chat_page.dart';
import 'package:chat_app/chatApp/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Talk Chat App!!',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black
          )),
      home: LoginPage(),
      routes: {
        '/chat': (context) => ChatPage()
      },
    );
  }
}
