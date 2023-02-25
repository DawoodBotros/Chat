import 'package:chat/DatabaseUtils/database_utils.dart';
import 'package:chat/base.dart';
import 'package:chat/models/my_user.dart';
import 'package:chat/screens/login_screen/login_screen_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../shared/components/firebase_errors.dart';

class LoginScreenViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;

  void loginFirebaseAuth(String email, String Password) async {
    try {
      navigator?.showLoading();
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: Password,
      );
      navigator?.hideLoading();
      navigator?.showMessage("Successfully logged");
      MyUser? myUser =
          await DatabaseUtils.readUserFromFirestore(credential.user?.uid ?? "");
      if(myUser !=null){
        navigator!.hideLoading();
        navigator!.goToHome(myUser);
        return;
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage('wrong email or password');
    } catch (e) {
      print(e);
    }
  }

}
