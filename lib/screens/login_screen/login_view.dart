import 'package:chat/base.dart';
import 'package:chat/models/my_user.dart';
import 'package:chat/screens/create_account/create_account.dart';
import 'package:chat/screens/home_screen/home_view.dart';
import 'package:chat/screens/login_screen/login_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/my_provider.dart';
import 'login_screen_navigator.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginScreenViewModel>
    implements LoginNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var PasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "assets/images/home.png",
        fit: BoxFit.cover,
        width: double.infinity,
      ),
      Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text("Login"),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  validator: (value) {
                    if (value!.trim() == "") {
                      return "Please Enter email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: PasswordController,
                  validator: (value) {
                    if (value!.trim() == "") {
                      return "Please Enter password";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      ValidateForm();
                    },
                    child: Text("Login")),
                TextButton(onPressed: (){
                 Navigator.pushReplacementNamed(context, CreateAccountScreen.routeName);
                }, child: Text("Don't Have An Account ?")),

              ],
            ),
          ),
        ),
      ),
    ]);
  }

  void ValidateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.loginFirebaseAuth(
          emailController.text, PasswordController.text);
    }
  }

  @override
  LoginScreenViewModel initViewModel() {
    return LoginScreenViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    // TODO: implement goToHome
    var provider = Provider.of<MyProvider>(context,listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
