import 'package:chat/screens/create_account/create_account.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   initialRoute: CreateAccountScreen.routeName,
      routes: {
       CreateAccountScreen.routeName : (context) => CreateAccountScreen(),
      },
    );
  }
}

