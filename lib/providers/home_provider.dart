import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libraryapp/podo/category.dart';
import 'package:libraryapp/podo/entry.dart';
import 'package:libraryapp/podo/filter_rule.dart';
import 'package:libraryapp/podo/user.dart';
import 'package:libraryapp/util/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diacritic/diacritic.dart';
import 'package:libraryapp/util/auth.dart';
import 'package:libraryapp/util/consts.dart';

class HomeProvider with ChangeNotifier {
  String message;
  CategoryFeed top = CategoryFeed();
  CategoryFeed recent = CategoryFeed();
  CategoryFeed search = CategoryFeed();
  CategoryFeed allProducts = CategoryFeed();
  EntryCategoryFeed categories = EntryCategoryFeed();
  User currentUser = User();
  bool loading = true;
  bool isLogin = false;
  FilterRule filterRule = FilterRule(List());

  // HomeProvider(String userJson) {
  //   if (userJson != null && userJson.isNotEmpty) {
  //     this.currentUser = User.fromJson(jsonDecode(userJson));
  //     isLogin = true;
  //   }
  // }

  HomeProvider() {
    AuthStateProvider.getLoginState().then((user) {
      if (user != null) {
        this.currentUser = user;
        isLogin = true;
      }
    });
  }

  getFeeds() async {
    setLoading(true);
    Api.getCategory(
            // Api.popular + "?recent&limit=" + Constants.topEntry.toString()
            Api.apiUrl+'filterBooks?new')
        .then((popular) {
      setTop(popular);
      Api.getEntryCategory(Api.categories).then((categories) {
        setEntryCategory(categories);
      }).catchError((e) {
        throw (e);
      });

      Api.getCategory(Api.apiUrl + 'filterBooks?special')

              // "?recent&special&limit=" +
              // Constants.specialAreaEntry.toString())
          .then((recent) {
        setRecent(recent);
        setLoading(false);
      }).catchError((e) {
        throw (e);
      });
      searchKeyword();
    }).catchError((e) {
      throw (e);
    });
  }

  searchKeyword([String keyword]) async {
    setLoading(true);
    if(allProducts.feed == null)
    await Api.getCategory(Api.apiUrl + 'books').then((products) {
        allProducts = products;
      });
    if (keyword == null || keyword.isEmpty) {
        setSearch(CategoryFeed.clone(allProducts));
        setLoading(false);
    } else {
       executeFilter();
      List _search = search.feed.entry
          .where((e) => removeDiacritics(e.title.t.trim().toLowerCase())
              .contains(removeDiacritics(keyword.trim().toLowerCase())))
          .toList();
      search.feed.entry = _search;
      notifyListeners();
      setLoading(false);
    }
  }

  Future<bool> validateAndSubmit() async {
    setLoading(true);
    dynamic user = await Api.getUser(Api.user +
        "/login?email=" +
        currentUser.email +
        "&password=" +
        currentUser.password);
    if (user.feed != null) {
      AuthStateProvider.setCurrentUser(user);
      isLogin = true;
      setLoading(false);
      return true;
    } else {
      setMessage(
          ("Email or password is incorrect.\nPlease try again").toString());
      setLoading(false);
      return false;
    }
  }

  void logout() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove("currentUserEmail");
    AuthStateProvider.removeCurrentUser();
    currentUser = User();
    isLogin = false;
  }

  void toggleFilter(int catId) {
    //REVIEW:  Viết ra 1 mảng lưu trữ tất cả các executeFilter
    // Nếu filterId đã có thì xóa đi, không thì thêm vào

    // categories.feed[catId].isChoose =
    if (filterRule.categories.contains(catId))
      filterRule.categories.remove(catId);
    else
      filterRule.categories.add(catId);

      //REVIEW: tách phần dưới thành hàm riêng dùng cho cả search và toggleFilter()
    executeFilter().then((value) => notifyListeners());
  }

  Future<void> executeFilter() async{
    if(filterRule.categories.isNotEmpty){
    List _filter = allProducts.feed.entry.where((element) {
      if(filterRule.categories.contains(int.parse(element.categoryId.t))){
        return true;
      }
      return false;
    }).toList();
    search.feed.entry = _filter;
    }else{
      setSearch(CategoryFeed.clone(allProducts));
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
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white10,
        timeInSecForIos: 5,
        textColor: Colors.redAccent);
    notifyListeners();
  }

  String getMessage() {
    return message;
  }

  void setTop(value) {
    top = value;
    notifyListeners();
  }

  CategoryFeed getTop() {
    return top;
  }

  void setSearch(value) {
    search = value;
    notifyListeners();
  }

  CategoryFeed getSearch() {
    return search;
  }

  void setRecent(value) {
    recent = value;
    notifyListeners();
  }

  CategoryFeed getRecent() {
    return recent;
  }

  void setEntryCategory(value) {
    categories = value;
    notifyListeners();
  }

  EntryCategoryFeed getEntryCategory() {
    return categories;
  }
}
