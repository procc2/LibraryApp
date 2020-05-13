class UserFeed{
  List<User> feed;

  UserFeed({this.feed});

  UserFeed.fromJson(dynamic json ){
    if (json != null && json != "") {
      String t = json.runtimeType.toString();
      if(t == "List<dynamic>" || t == "_GrowableList<dynamic>"){
        feed = new List<User>();
        json.forEach((entryCategory){
          feed.add(User.fromJson(entryCategory));
        });
      }else{
        feed = new List<User>();
        feed.add(new User.fromJson(json));
      }
    }
  }
}

class User{
  int id;
  String email;
  String password;
  int role;

  User({this.id,this.email,this.password,this.role});

  User.fromJson(Map<String,dynamic> json ){
      id = json['id_thanhvien'] != null ? json['id_thanhvien'] : null;
      email = json['email'] != null ? json['email'] : null;
      password = json['mat_khau'] != null ? json['mat_khau'] : null;
      role = json['quyen_truy_cap'] != null ? json['quyen_truy_cap'] : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_thanhvien'] = this.id;
    data['email'] = this.email;
    data['mat_khau'] = this.password;
    data['quyen_truy_cap'] = this.role;
    
    return data;
  }
}