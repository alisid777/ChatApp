import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:usertouserchat/auth/auth_services.dart';
import 'package:usertouserchat/chat/chat_service.dart';
import 'package:usertouserchat/components/my_drawer.dart';
import 'package:usertouserchat/pages/chatpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: _buildUser(),
      drawer: MyDrawer(),
    );
  }
}

Widget _buildUser() {
  ChatService chatService = ChatService();
  return FutureBuilder<List<Map<String, dynamic>>>(
      future: chatService.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No users found"));
        } else {
          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(ChatPage(),
                          arguments: {'nextPersonEmail': user['email']});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(user['email']),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      });
}
