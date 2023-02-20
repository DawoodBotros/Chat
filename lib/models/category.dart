class RoomCategory {

  static const String sportsID = "sports";
  static const String musicID  = "music";
  static const String moviesID = "movies";
  String id;
  late String title;
  late String image;
  RoomCategory(this.id,this.title,this.image);
  RoomCategory.fromID(this.id){
    title = id;
    image = "assets/images/$id.jpeg";
  }

  static List<RoomCategory> getCategories(){
    return [
      RoomCategory.fromID(sportsID),
      RoomCategory.fromID(musicID),
      RoomCategory.fromID(moviesID),

    ];
  }
}