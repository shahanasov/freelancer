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
        .set(
            {
          'participants': ids, // Ensure both participants are listed
          'lastMessageTimestamp':
              timestamp, // Optionally, track when the last message was sent
        },
            SetOptions(
                merge:
                    true)); // Merge to prevent overwriting any existing fields

    // Add the new message to the messages sub-collection
    // await FirebaseFirestore.instance
    //     .collection("chat_rooms")
    //     .doc(chatroomId)
    //     .collection("messages");
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
  Future<List<String>> getMessagedUsers(String currentUserId) async {
    List<String> messagedUserIds = [];

    // Query chat_rooms collection where the current user is a participant
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chat_rooms')
        .where('participants', arrayContains: currentUserId)
        .get();

    // Iterate through the chat rooms and extract the other user IDs
    for (var doc in querySnapshot.docs) {
      List<String> participants = List<String>.from(doc['participants']);

      // Remove the current user from the participants list to get the other user
      participants.remove(currentUserId);

      if (participants.isNotEmpty) {
        messagedUserIds.add(participants.first); // Add the other user ID
      }
    }
    print(messagedUserIds);

    return messagedUserIds;
  }
}
