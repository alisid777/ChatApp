import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:usertouserchat/auth/auth_services.dart';
import 'package:usertouserchat/chat/chat_service.dart';
import 'package:usertouserchat/components/my_textfield.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String recieverId = Get.arguments['nextPersonEmail'];
  TextEditingController messageController = TextEditingController();

  AuthServices authServices = AuthServices();
  ChatService chatService = ChatService();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      chatService.sendMessage(recieverId, messageController.text);

      //clear the controller
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['nextPersonEmail']),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String? senderId = FirebaseAuth.instance.currentUser?.uid;
    return StreamBuilder(
      stream: chatService.getMessages(senderId, recieverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Loading messages'));
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ListTile(
      title: Text(data['message']),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              hint: 'Message',
              obsecureText: false,
              controller: messageController,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
