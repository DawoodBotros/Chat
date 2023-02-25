import 'package:chat/screens/chat/chat_view.dart';
import 'package:flutter/material.dart';

import '../../models/room.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.routeName, arguments: room);
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 15.0,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/${room.catID}.jpeg",
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width * 0.35,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text("${room.title}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
