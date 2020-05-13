import 'package:dio/dio.dart';
import 'package:libraryapp/podo/category.dart';
import 'package:libraryapp/podo/entry.dart';
import 'package:libraryapp/podo/user.dart';

class Api {

  //Local API
  
  // static String baseURL =
  //     "http://localhost:3000/";
  static String baseURL =
      "https://kma-library-api.herokuapp.com/";
  static String apiUrl = 
      "https://kma-library-web.herokuapp.com/api/v1/";
  static String popular =
      baseURL + "anpham";
  static String categories =
      apiUrl + "categories";
  static String user =
      baseURL + "user";
  static String favorite = 
      baseURL + "favorite";
  static String rental = 
      baseURL + "boughtHistory";

  static Future<CategoryFeed> getCategory(String url) async {
    try{
    Dio dio = Dio();

    var res = await dio.get(url);
    CategoryFeed category;
    if(res.statusCode == 200){
      // Xml2Json xml2json = new Xml2Json();
      // xml2json.parse(res.data.toString());
      // var json = jsonDecode(xml2json.toGData());
      category = CategoryFeed.fromJson(res.data);
    }else{
      throw("Error ${res.statusCode}");
    }
    return category;
    }catch(e){
      throw(e);
    }
  }

  static Future<EntryCategoryFeed> getEntryCategory(String url) async {
    try{
    Dio dio = Dio();

    var res = await dio.get(url);
    EntryCategoryFeed entryCategory;
    if(res.statusCode == 200){
      // Xml2Json xml2json = new Xml2Json();
      // xml2json.parse(res.data.toString());
      // var json = jsonDecode(xml2json.toGData());
      entryCategory = EntryCategoryFeed.fromJson(res.data);
    }else{
      throw("Error ${res.statusCode}");
    }
    return entryCategory;
    }catch(e){
      print(e);
      return null;
    }
  }

  static Future<UserFeed> getUser(String url) async{
    try {
      Dio dio = Dio();

      var res = await dio.get(url);
      UserFeed userFeed;

      if(res.statusCode == 200){
        userFeed = UserFeed.fromJson(res.data);
      }else{
        throw("Error ${res.statusCode}");
      }
      return userFeed;
    } catch (e) {
      throw(e);
    }
  }

  static Future<List> getFavoriteByUserId(String url) async {
    try{
      Dio dio = Dio();
      
      var res = await dio.get(url);
      List productIds = List();
      
      if(res.statusCode == 200){
        // productIds = FavoriteFeed.fromJson(res.data);
        res.data.forEach((item){
          productIds.add(item["id_ap"]);
        });
      }else{
        throw("Error ${res.statusCode}");
      }
      return productIds;
      // return favoriteFeed;
    }catch(e){
      throw e;
    }
  }

  static addFavorite(String entryId, int userId) async{
    try{
      Dio dio = Dio();

      await dio.post(
        Api.favorite,
        data: {
          "id_ap" : entryId,
          "id_thanhvien" : userId
        }
        );
    }catch(e){
      throw(e);
    }
  }

  static deleteFavorite(String entryId, int userId) async {
    try{
      Dio dio = Dio();
      await dio.delete(
        Api.favorite,
        data: {
          "id_ap" : entryId,
          "id_thanhvien" : userId
        });
    }catch(e){
      throw(e);
    }
  }
}
