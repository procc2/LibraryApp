import 'package:flutter/material.dart';
import 'package:libraryapp/podo/category.dart';
import 'package:libraryapp/podo/entry.dart';
import 'package:libraryapp/providers/home_provider.dart';
import 'package:libraryapp/screen/genre.dart';
import 'package:libraryapp/util/api.dart';
import 'package:libraryapp/util/consts.dart';
import 'package:libraryapp/widgets/book_card.dart';
import 'package:libraryapp/widgets/book_list_item.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider homeProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "${Constants.appName}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          body: homeProvider.loading
              ? Center(child: CircularProgressIndicator(),)
              : RefreshIndicator(
            onRefresh: ()=>homeProvider.getFeeds(),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 200,
                  child: Center(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: homeProvider.recent.feed.entry.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        Entry entry = homeProvider.recent.feed.entry[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: BookCard(
                            img: homeProvider.recent.feed.entry[index].files.isNotEmpty ?
                            homeProvider.recent.feed.entry[index].files.single.title
                            : null,
                            entry: entry,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  height: 50,
                  child: Center(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: homeProvider.categories.feed.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        EntryCategory category = homeProvider.categories.feed[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.all(Radius.circular(20),),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.all(Radius.circular(20),),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: Genre(
                                      title: category.name,
                                      url: Api.apiUrl+"filterBooks?categoryId="+ category.id.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    category.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Recently Added",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

//                InkWell(
//                  onTap: (){
//                    Navigator.push(
//                      context,
//                      PageTransition(
//                        type: PageTransitionType.rightToLeft,
//                        child: Genre(),
//                      ),
//                    );
//                  },
//                  child: Text(
//                    "See All",
//                    style: TextStyle(
//                      color: Theme.of(context).accentColor,
//                      fontWeight: FontWeight.w400,
//                    ),
//                  ),
//                ),
                    ],
                  ),
                ),

                SizedBox(height: 20,),

                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.top.feed.entry.length,
                  itemBuilder: (BuildContext context, int index) {
                    Entry entry = homeProvider.top.feed.entry[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: BookListItem(
                        img: entry.files.isNotEmpty ? entry.files.single.title : null,
                        title: entry.title.t,
                        author: entry.author.name.t,
                        desc: entry.summary.t,
                        entry: entry,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
