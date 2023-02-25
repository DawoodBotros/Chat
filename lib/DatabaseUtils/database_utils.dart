import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';
import '../models/my_user.dart';
import '../models/room.dart';

class DatabaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.COLLECTION_NAME)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.COLLECTION_NAME)
        .withConverter(
          fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
          toFirestore: (room, options) => room.toJson(),
        );
  }

  static CollectionReference<Message> getMessageCollection(String roomID) {
    return getRoomsCollection()
        .doc(roomID)
        .collection(Message.COLLECTION_NAME)
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addMessageToFirebase(Message message) {
    var docRef = getMessageCollection(message.roomID).doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> readMessageFromToFirebase(
      String roomID) {
    return getMessageCollection(roomID).orderBy("dateTime").snapshots();
  }

  static Future<void> AddRoomsToFirestore(Room room) {
    var collection = getRoomsCollection();
    var docRef = collection.doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<void> AddUserToFirestore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<List<Room>> readRoomsFromFirestore() async {
    QuerySnapshot<Room> snapshotRooms = await getRoomsCollection().get();
    return snapshotRooms.docs.map((doc) => doc.data()).toList();
  }

  static Future<MyUser?> readUserFromFirestore(String id) async {
    DocumentSnapshot<MyUser> user = await getUsersCollection().doc(id).get();

    var myUser = user.data();
    return myUser;
  }
}
