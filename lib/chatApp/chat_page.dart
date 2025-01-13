import 'dart:convert';

import 'package:chat_app/chatApp/models/chat_message_entity.dart';
import 'package:chat_app/chatApp/widgets/chat_bubble.dart';
import 'package:chat_app/chatApp/widgets/chat_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // initiate State of Messages
  List<ChatMessageEntity> _messages= [];

  _loadInitialMessages() async{
    final response = await rootBundle.loadString("assets/mock_message.json");

    final List<dynamic> decodedList = jsonDecode(response) as List;

    final List<ChatMessageEntity> _chatMessages = decodedList.map((listItem){
      return ChatMessageEntity.fromJson(listItem);
    }).toList();

    print(_chatMessages.length);


    // final state of the messages
    setState(() {
      _messages = _chatMessages;
    });
  }


  onMessageSent(ChatMessageEntity entity) {
    _messages.add(entity);
    setState(() {

    });
  }

  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi $username!'),
        actions: [
          IconButton(
              onPressed: (){

                Navigator.pushReplacementNamed(context, '/');
                print('Icon pressed');
                },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
                itemBuilder: (context, index){
              return ChatBubble(
                  alignment:
                      _messages[index].author.userName == 'Lokesh007'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  entity: _messages[index]);
            })
          ),
          ChatInputs(onSubmit: onMessageSent,),
        ],
      ),
    );
  }
}
