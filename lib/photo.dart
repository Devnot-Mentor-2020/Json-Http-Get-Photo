class Photo {

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Photo.fromJsonMap(Map<String, dynamic> map): 
    albumId = map["albumId"],
    title=map["title"],
    id = map["id"],
    url = map["url"],
    thumbnailUrl = map["thumbnailUrl"];

}