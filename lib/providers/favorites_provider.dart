import 'package:flutter/foundation.dart';
import 'package:libraryapp/database/favorite_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:libraryapp/podo/user.dart';
import 'package:libraryapp/util/api.dart';
import 'package:libraryapp/util/auth.dart';

class FavoritesProvider extends ChangeNotifier {
  String message;
  List posts = List();
  bool loading = true;
  var db = FavoriteDB();

  // FavoritesProvider(String userJson) {
  //   if (userJson != null && userJson.isNotEmpty) {
  //     this.currentUser = User.fromJson(jsonDecode(userJson));
  //   }
  // }
  // FavoritesProvider() {
  //   AuthStateProvider.getLoginState().then((user) {
  //     if (user != null) {
  //       this.currentUser = user;
  //     }
  //   });
  // }

  getFeed() async {
    setLoading(true);
    posts.clear();


    User currentUser = await AuthStateProvider.getLoginState();

    if(currentUser != null) {
    Api.getFavoriteByUserId(
            Api.favorite + "?id_thanhvien=" + currentUser.id.toString())
        .then((entries) {
      if(entries.isEmpty || entries == null) setLoading(false);
      else
      for (int i = 0; i < entries.length; i++) {
        Api.getCategory(Api.apiUrl + "/book" + entries[i].toString())
            .then((value) {
          posts.add(value.feed.entry.single);
          setLoading(false);
        });
      }
    });
    }else{
    db.listAll().then((all){
      if(all.isEmpty || all == null ) setLoading(false);
      else
      all.forEach((element) {
        Api.getCategory(Api.apiUrl + "/" + element["id"].toString())
            .then((value) {
          posts.add(value.feed.entry.single);
          setLoading(false);
        });
      });
    });
    }
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setMessage(value) {
    message = value;
    Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
    );
    notifyListeners();
  }

  String getMessage() {
    return message;
  }

  void setPosts(value) {
    posts = value;
    notifyListeners();
  }

  List getPosts() {
    return posts;
  }
}
