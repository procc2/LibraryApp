import 'package:flutter/material.dart';
import 'package:libraryapp/podo/category.dart';
import 'package:libraryapp/podo/entry.dart';
import 'package:libraryapp/providers/home_provider.dart';
import 'package:libraryapp/screen/genre.dart';
import 'package:libraryapp/util/api.dart';
import 'package:libraryapp/widgets/book_card.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Explore extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider homeProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Explore",
            ),
          ),

          body: homeProvider.loading
              ? Center(child: CircularProgressIndicator(),)
              : ListView.builder(
            itemCount: homeProvider.categories.feed.length,
            itemBuilder: (BuildContext context, int index) {
              EntryCategory category = homeProvider.categories.feed[index];

              // print(Api.baseURL+link.href);
              // if(index < 10){
              //   return SizedBox();
              // }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Genre(
                                    title: category.name,
                                    url: Api.apiUrl+"filterBooks?categoryId=" + category.id.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10,),

                    FutureBuilder<CategoryFeed>(
                        future: Api.getCategory(Api.apiUrl+"filterBooks?categoryId="+ category.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {

                            CategoryFeed category = snapshot.data;

                            return Container(
                              height: 200,
                              child: Center(
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    if (!category.feed.entry.asMap().containsKey(index) ){
                                      return null;
                                    }
                                    Entry entry = category.feed.entry[index];

                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                      child: BookCard(
                                        img: entry.files.isNotEmpty ? entry.files.single.title : null,
                                        entry: entry,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );

                          } else {
                            return Container(
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        }
                    ),
                  ],
                ),
              );
            },

          ),
        );
      },
    );
  }
}
