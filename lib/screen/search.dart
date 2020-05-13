import 'package:flutter/material.dart';
import 'package:libraryapp/podo/category.dart';
import 'package:libraryapp/podo/entry.dart';
import 'package:libraryapp/providers/app_provider.dart';
import 'package:libraryapp/providers/home_provider.dart';
import 'package:libraryapp/util/consts.dart';
import 'package:libraryapp/widgets/book_list_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider homeProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Search",
            ),
            actions: <Widget>[
              new Container(),
            ],
          ),
          body: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              // print(Api.baseURL+link.href);
              // if(index < 10){
              //   return SizedBox();
              // }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          homeProvider.searchKeyword(value);
                        },
                        decoration: InputDecoration(
                            labelText: "Search",
                            hintText: "Search",
                            prefixIcon: Icon(Feather.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                            suffixIcon: IconButton(
                                icon: new Icon(
                                  Feather.filter,
                                  color:
                                      Provider.of<AppProvider>(context).theme ==
                                              Constants.lightTheme
                                          ? Constants.darkPrimary
                                          : Constants.lightPrimary,
                                  size: 25,
                                ),
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();
                                })),
                      ),
                    ),
                    homeProvider.isLoading()
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : homeProvider.search.feed.entry.length > 0
                            ? ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    homeProvider.search.feed.entry.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Entry entry =
                                      homeProvider.search.feed.entry[index];
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: BookListItem(
                                      img: entry.files.isNotEmpty ? entry.files.single.title : null,
                                      title: entry.title.t,
                                      author: entry.author.name.t,
                                      desc: entry.summary.t,
                                      entry: entry,
                                    ),
                                  );
                                },
                              )
                            : Text(
                                "No product like that ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w100,
                                    fontStyle: FontStyle.italic),
                              ),
                  ],
                ),
              );
            },
          ),
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 100,
                  child: DrawerHeader(
                    child: Text('Filter'),
                    decoration: BoxDecoration(
                      color: Constants.darkAccent,
                    ),
                  ),
                ),
                Hero(
                  tag: "Category",
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  // height: homeProvider.categories.feed.length < 3 ? 40 : 80,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homeProvider.categories.feed.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 210 / 80,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      EntryCategory cat = homeProvider.categories.feed[index];
                      // Category cat = entry.category[index];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: homeProvider.filterRule.categories
                                      .contains(cat.id)
                                  ? Theme.of(context).focusColor
                                  : Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: Text(
                                    "${cat.name}",
                                    style: TextStyle(
                                      color: homeProvider.filterRule.categories
                                              .contains(cat.id)
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).accentColor,
                                      fontSize: cat.name.length > 18 ? 13 : 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ),
                          onTap: () {
                            homeProvider.toggleFilter(cat.id);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
