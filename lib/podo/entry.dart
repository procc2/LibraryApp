class EntryCategoryFeed{
  List<EntryCategory> feed;

  EntryCategoryFeed({this.feed});

  EntryCategoryFeed.fromJson(dynamic json ){
    if (json != null) {
      String t = json.runtimeType.toString();
      if(t == "List<dynamic>" || t == "_GrowableList<dynamic>"){
        feed = new List<EntryCategory>();
        json.forEach((entryCategory){
          feed.add(EntryCategory.fromJson(entryCategory));
        });
      }else{
        feed = new List<EntryCategory>();
        feed.add(new EntryCategory.fromJson(json));
      }
    }
  }
}

class EntryCategory{
  int id;
  String name;

  EntryCategory({this.id,this.name});

  EntryCategory.fromJson(Map<String,dynamic> json ){
      id = json['category_id'] != null ? json['category_id'] : null;
      name = json['category_name'] != null ? json['category_name'] : null;
  }
}