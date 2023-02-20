import 'package:chat/DatabaseUtils/database_utils.dart';
import 'package:chat/base.dart';
import 'package:chat/models/my_user.dart';
import 'package:chat/screens/create_account/create_account_navigator.dart';
import 'package:chat/shared/components/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountViewModel extends BaseViewModel<BaseAccountNavigator> {
  var auth =FirebaseAuth.instance;
  void createAccountFirebaseAuth(
      String email, String Password, String firstName, String userName) async {
    try {
      navigator?.showLoading();
      final credential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: Password,
      );
      navigator?.hideLoading();
      navigator?.showMessage("Account Created");
      MyUser myUser = MyUser(
          id: credential.user?.uid ?? "",
          fName: firstName,
          userName: userName,
          email: email);
      DatabaseUtils.AddUserToFirestore(myUser);
      if(myUser != null){
        navigator!.hideLoading();
        navigator!.goToHome(myUser);
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.weakpassword) {
        navigator?.hideLoading();
        navigator?.showMessage('The password provided is too weak.');
      } else if (e.code == FirebaseError.emailinuse) {
        navigator?.hideLoading();
        navigator?.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
