import 'package:chat/base.dart';
import 'package:chat/providers/my_provider.dart';
import 'package:chat/screens/chat/chat_view_model.dart';
import 'package:chat/screens/chat/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/room.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatScreen, ChatViewModel>
    implements ChatNavigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  var messageController = TextEditingController();

  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    viewModel.room = room;
    var provider = Provider.of<MyProvider>(context);
    viewModel.myUser = provider.myUser!;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/home.png",
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(room.title),
              centerTitle: true,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 15.0,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ],
              ),
              child: Container(
                padding: const EdgeInsets.only(bottom: 6, left: 5),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: viewModel.getMessages(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Text("something went wrong");
                          }
                          var messages =
                              snapshot.data?.docs.map((e) => e.data()).toList();
                          return ListView.builder(
                            itemCount: messages?.length ?? 0,
                            itemBuilder: (context, index) {
                              return MessageWidget(messages![index]);
                            },
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              hintText: "Type a messages",
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.sendMessage(messageController.text);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue),
                            child: Row(
                              children: const [
                                Text(
                                  "Send",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  void uploadMessageToFireStroe() {
    messageController.clear();
    setState(() {});
  }
}
