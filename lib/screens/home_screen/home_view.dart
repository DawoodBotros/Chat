import 'package:chat/base.dart';
import 'package:chat/screens/add_room/add_room_screen.dart';
import 'package:chat/screens/home_screen/home_view_model.dart';
import 'package:chat/screens/home_screen/room_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_screen/login_view.dart';
import 'home_navigator.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    viewModel.readRoom();
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/home.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoomScreen.routeName);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text("Chat-App"),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                ),
              ],
            ),
            body: Consumer<HomeViewModel>(
              builder: (context, homeViewModel, child) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  itemCount: homeViewModel.rooms.length,
                  itemBuilder: (context, index) {
                    return RoomWidget(homeViewModel.rooms[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}
