import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:usertouserchat/models/messagemodel.dart';

class ChatService {
  //Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  // get all the users
  User? currentUser;
  void getCurrentLoggedInUser() async {
    final User? user = auth.currentUser;
    currentUser = user;
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      getCurrentLoggedInUser();
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      final fetchedDocs = snapshot.docs;
      if (fetchedDocs.isNotEmpty) {
        print(fetchedDocs[0].data()); // Prints the data of the first document
      }
      // Transforming the list of QueryDocumentSnapshot to a list of maps
      List<Map<String, dynamic>> users = fetchedDocs
          .map((doc) => doc.data())
          .where((user) => user['id'] != currentUser?.uid)
          .toList();
      return users;
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }

  //send message

  void sendMessage(String recieverId, String message) {
    //get current user
    String currentUseruId = auth.currentUser!.uid;
    String currentUserEmail = auth.currentUser?.email ?? "siddiqui@gmail.com";
    final timestamp = Timestamp.now();

    //Create Message

    MessageModel newMessage = MessageModel(
        senderId: currentUseruId,
        senderEmail: currentUserEmail,
        recieverId: recieverId,
        message: message,
        timestamp: timestamp);

    // store the message

    List<String> ids = [currentUseruId, recieverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    //add it to firestore
    firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get message

  Stream<QuerySnapshot> getMessages(currentUserId, otherUserId) {
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
