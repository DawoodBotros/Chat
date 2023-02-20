import 'package:chat/base.dart';
import 'package:chat/models/my_user.dart';

abstract class BaseAccountNavigator extends BaseNavigator{
  void goToHome(MyUser myUser);
}