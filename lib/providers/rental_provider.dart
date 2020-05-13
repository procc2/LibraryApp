import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:libraryapp/podo/user.dart';
import 'package:libraryapp/util/api.dart';
import 'package:libraryapp/util/auth.dart';

class RentalProvider extends ChangeNotifier {
  String message;
  List posts = List();
  bool loading = true;
  User currentUser = User();

  // RentalProvider(String userJson) {
  //   if (userJson != null && userJson.isNotEmpty) {
  //     this.currentUser = User.fromJson(jsonDecode(userJson));
  //   }
  // }

  // RentalProvider() {
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
    // db.listAll().then((all){
    //   posts.addAll(all);
    //   setLoading(false);
    // });
    await Api.getFavoriteByUserId(
            Api.rental + "?id_thanhvien=" + currentUser.id.toString())
        .then((entries) async {
      for (int i = 0; i < entries.length; i++) {
        await Api.getCategory(Api.popular + "/" + entries[i].toString()).then((value) {
          posts.add(value.feed.entry.single);
        }).catchError((e){
          throw(e);
        });
      }
    }).catchError((e){
      throw(e);
    });
    setLoading(false);
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
