import 'package:chat/DatabaseUtils/database_utils.dart';
import 'package:chat/base.dart';
import 'package:chat/models/room.dart';
import 'package:chat/screens/add_room/add_room_navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void AddRoomToDb(String title, String desc, String catID) {
    Room room = Room(title: title, desc: desc, catID: catID);
    DatabaseUtils.AddRoomsToFirestore(room).then((value) {
      navigator!.roomCreated();
    }).catchError((error) {});
  }
}
