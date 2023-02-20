class Message {
  static String COLLECTION_NAME = "Messages";
  String id;
  String content;
  int dateTime;
  String roomID;
  String senderId;
  String senderName;

  Message(
      {this.id = "",
      required this.content,
      required this.dateTime,
      required this.roomID,
      required this.senderId,
      required this.senderName});

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          content: json["content"],
          dateTime: json["dateTime"],
          roomID: json["roomID"],
          senderId: json["senderId"],
          senderName: json["senderName"],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "dateTime": dateTime,
      "roomID": roomID,
      "senderId": senderId,
      "senderName": senderName,
    };
  }
}
