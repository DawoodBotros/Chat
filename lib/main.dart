import 'package:chat/firebase_options.dart';
import 'package:chat/providers/my_provider.dart';
import 'package:chat/screens/add_room/add_room_screen.dart';
import 'package:chat/screens/chat/chat_view.dart';
import 'package:chat/screens/create_account/create_account.dart';
import 'package:chat/screens/home_screen/home_view.dart';
import 'package:chat/screens/login_screen/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser != null
          ? HomeScreen.routeName
          : LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        CreateAccountScreen.routeName: (context) => CreateAccountScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddRoomScreen.routeName: (context) => AddRoomScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
      },
    );
  }
}
