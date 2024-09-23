import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance/db/model/message_model.dart';

class ChatServices {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  Future<void> sendMessage(String recieverId, message) async {
    //get current user info

    final String userEmailId = FirebaseAuth.instance.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    MessageModel newMessage = MessageModel(
      senderId: userId,
      senderEmail: userEmailId,
      recieverId: recieverId,
      message: message,
      timestamp: timestamp,
    );
    //  construct chat room id for 2 users(sorted to ensure uniqueness)
    List<String> ids = [userId, recieverId];
    ids.sort(); //sort the ids (to ensure chatroomid is the same for any 2 people)
    String chatroomId = ids.join('_');
    await FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // add new message to database
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //construct a chatroom id for the two users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatroomId = ids.join('_');
    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // Fetch chat rooms for the current user
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getChatRooms() {
    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .where('senderId', isEqualTo: userId)
        .snapshots()
        .asyncMap((senderSnapshot) async {
      QuerySnapshot<Map<String, dynamic>> receiverSnapshot =
          await FirebaseFirestore.instance
              .collection('chat_rooms')
              .where('recieverId', isEqualTo: userId)
              .get();

      // Combine both lists of documents
      final allDocs = [...senderSnapshot.docs, ...receiverSnapshot.docs];
      return allDocs;
    });
  }
  
}
