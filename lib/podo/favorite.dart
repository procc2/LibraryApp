class FavoriteFeed {
  List<FavoriteData> feed;
  FavoriteFeed({this.feed});
  FavoriteFeed.fromJson(dynamic json){
    if (json != null) {
      String t = json.runtimeType.toString();
      if(t == "List<dynamic>" || t == "_GrowableList<dynamic>"){
        feed = new List<FavoriteData>();
        json.forEach((entryCategory){
          feed.add(FavoriteData.fromJson(entryCategory));
        });
      }else{
        feed = new List<FavoriteData>();
        feed.add(new FavoriteData.fromJson(json));
      }
    }
  }
  }
  
  class FavoriteData {
    int userId;
    int productId;
  FavoriteData.fromJson(json){
    userId = json['id_thanhvien'] != null ? json['id_thanhvien'] : null;
    productId = json['id_ap'] != null ? json['id_ap'] : null;
  }
}