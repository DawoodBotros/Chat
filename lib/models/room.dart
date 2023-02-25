class Room {
  static const String COLLECTION_NAME = "Room";
  String id;
  String title;
  String desc;
  String catID;

  Room(
      {this.id = "",
      required this.title,
      required this.desc,
      required this.catID});

  Room.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          desc: json["desc"],
          catID: json["catID"],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "desc": desc,
      "catID": catID,
    };
  }
}
