import 'package:chat/base.dart';
import 'package:chat/models/my_user.dart';

abstract class LoginNavigator extends BaseNavigator{
  void goToHome(MyUser myUser);
}