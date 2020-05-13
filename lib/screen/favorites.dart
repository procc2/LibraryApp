import 'package:flutter/material.dart';
import 'package:libraryapp/podo/category.dart';
import 'package:libraryapp/providers/favorites_provider.dart';
import 'package:libraryapp/widgets/book.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (BuildContext context, FavoritesProvider favoritesProvider,
          Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Favorites",
            ),
          ),
          body: favoritesProvider.isLoading()
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : favoritesProvider.posts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/empty.png",
                            height: 300,
                            width: 300,
                          ),
                          Text(
                            "Nothing is here",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      shrinkWrap: true,
                      itemCount: favoritesProvider.posts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 200 / 340,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        Entry entry = favoritesProvider.posts[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: BookItem(
                            img: entry.files.isNotEmpty ? entry.files.single.title : null,
                            title: entry.title.t,
                            entry: entry,
                            isRentalPage: false,
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
