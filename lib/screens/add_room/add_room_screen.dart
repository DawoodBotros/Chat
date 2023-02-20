import 'package:chat/base.dart';
import 'package:chat/models/category.dart';
import 'package:chat/screens/add_room/add_room_navigator.dart';
import 'package:chat/screens/add_room/add_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = "add-room";

  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseView<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var descController = TextEditingController();
  var categories = RoomCategory.getCategories();
  late RoomCategory selectedRoom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    selectedRoom = categories[0];
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
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: const Text("Add Room"),
              centerTitle: true,
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                elevation: 20,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Create New Room",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset("assets/images/create-add-room.png"),
                        TextFormField(
                          controller: titleController,
                          validator: (value) {
                            if (value!.trim() == "") {
                              return "Please Enter title";
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
                              hintText: "title",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButton(
                          value: selectedRoom,
                          items: categories
                              .map(
                                (cat) => DropdownMenuItem(
                                  child: Row(
                                    children: [
                                      Image.asset(cat.image),
                                      SizedBox(width: 25,),
                                      Text(cat.title),
                                    ],
                                  ),
                                  value: cat,
                                ),
                              )
                              .toList(),
                          onChanged: (category) {
                            if (category == null) {
                              return;
                            } else {
                              selectedRoom = category;
                            }

                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: descController,
                          validator: (value) {
                            if (value!.trim() == "") {
                              return "Please Enter Description";
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
                              hintText: "Description",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16))),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              ValidateForm();
                            },
                            child: Text("Create Room")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void roomCreated() {
    // TODO: implement roomCreated
    Navigator.pop(context);
  }
  void  ValidateForm(){
    if(formKey.currentState!.validate()){
      viewModel.AddRoomToDb(titleController.text, descController.text, selectedRoom.id);
    }
  }
  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }
}
