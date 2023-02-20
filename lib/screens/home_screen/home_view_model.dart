import 'package:chat/DatabaseUtils/database_utils.dart';
import 'package:chat/base.dart';
import 'package:chat/screens/home_screen/home_navigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List rooms = [];

  void readRoom() {
    DatabaseUtils.readRoomsFromFirestore().then((value) {
      rooms = value;
    }).catchError((error) {
      navigator!.showMessage(error!.toString());
    });
  }
}
