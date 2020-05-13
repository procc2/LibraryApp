import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libraryapp/database/download_helper.dart';
import 'package:libraryapp/database/favorite_helper.dart';
import 'package:libraryapp/podo/category.dart';
import 'package:libraryapp/podo/entry.dart';
import 'package:libraryapp/podo/user.dart';
import 'package:libraryapp/util/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:libraryapp/util/auth.dart';

class DetailsProvider extends ChangeNotifier {
  String message;
  CategoryFeed related = CategoryFeed();
  EntryCategoryFeed entryCategory = EntryCategoryFeed();
  bool loading = false;
  Entry entry;
  User currentUser = User();
  var favDB = FavoriteDB();
  var dlDB = DownloadsDB();

  bool faved = false;
  bool downloaded = false;
  bool isLogin = false;

  static var httpClient = HttpClient();

  // DetailsProvider(String userJson){
  //   if(userJson != null && userJson.isNotEmpty){
  //   this.currentUser = User.fromJson(jsonDecode(userJson));
  //   }
  // }

  DetailsProvider() {
    AuthStateProvider.getLoginState().then((user) {
      if (user != null) {
        this.currentUser = user;
        this.isLogin = true;
      }
    });
    // Api.getFavoriteByUserId(Api.favorite+"?id_thanhvien=" + currentUser.id.toString()).then((ids) {
    //   favDB.addAll(ids);
    // });
  }

  getFeed() async {
    setLoading(true);
    await checkFav();
    currentUser = await AuthStateProvider.getLoginState();

    // checkDownload();
    // Api.getEntryCategory(Api.category + "/" + entry.categoryId.t).then((feed) {
    //   setEntryCategory(feed);
    // }).catchError((e) {
    //   throw (e);
    // });
    Api.getCategory(
            Api.apiUrl + "filterBooks?authorId=" + entry.author.id.t.toString())
        .then((response) {
      response.feed.entry.removeWhere((e) => e.id.t == entry.id.t);
      setRelated(response);
      setLoading(false);
    }).catchError((e) {
      throw (e);
    });
  }

  checkFav() async {
    List c;
    if (isLogin)
      c = await Api.getFavoriteByUserId(Api.favorite +
          "?id_thanhvien=" +
          currentUser.id.toString() +
          "&id_ap=" +
          entry.id.t);
    else
      c = await favDB.check({"id": entry.id.t});
    if (c.isNotEmpty) {
      setFaved(true);
    } else {
      setFaved(false);
    }
  }

  addFav() async {
    setFaved(true);
    if(isLogin)
    await Api.addFavorite(entry.id.t, currentUser.id);
    else
    await favDB.add({"id": entry.id.t});
    // checkFav();
  }

  removeFav() async {
    setFaved(false);
    if(isLogin)
    await Api.deleteFavorite(entry.id.t, currentUser.id);
    else 
    await favDB.remove({"id": entry.id.t});
  }

  checkDownload() async {
    List c = await dlDB.check({"id": entry.publisher});
    if (c.isNotEmpty) {
      setDownloaded(true);
    } else {
      setDownloaded(false);
    }
  }

  Future<List> getDownload() async {
    List c = await dlDB.check({"id": entry.publisher});
    return c;
  }

  addDownload(Map body) async {
    await dlDB.add(body);
    checkDownload();
  }

  removeDownload() async {
    dlDB.remove({"id": entry.publisher}).then((v) {
      print(v);
      checkDownload();
    });
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

  void setRelated(value) {
    related = value;
    notifyListeners();
  }

  CategoryFeed getRelated() {
    return related;
  }

  void setEntry(value) {
    entry = value;
    notifyListeners();
  }

  void setFaved(value) {
    faved = value;
    notifyListeners();
  }

  void setDownloaded(value) {
    downloaded = value;
    notifyListeners();
  }

  void setEntryCategory(value) {
    entryCategory = value;
    notifyListeners();
  }

  EntryCategoryFeed getEntryCategory() {
    return entryCategory;
  }
}
