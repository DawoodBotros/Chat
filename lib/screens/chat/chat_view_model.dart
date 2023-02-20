import 'package:chat/DatabaseUtils/database_utils.dart';
import 'package:chat/base.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/my_user.dart';
import 'package:chat/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  late MyUser myUser;
  void sendMessage(String content) {
    Message message = Message(
        content: content,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        roomID: room.id,
        senderId: myUser.id,
        senderName: myUser.userName);
    DatabaseUtils.addMessageToFirebase(message).then((value) {
      navigator!.uploadMessageToFireStroe();
    });
  }

  Stream<QuerySnapshot<Message>> getMessages(){
   return DatabaseUtils.readMessageFromToFirebase(room.id);
  }
}

abstract class ChatNavigator extends BaseNavigator {
  void uploadMessageToFireStroe();
}
