import 'package:flutter/material.dart';
import 'package:libraryapp/podo/user.dart';
import 'package:libraryapp/providers/app_provider.dart';
import 'package:libraryapp/providers/favorites_provider.dart';
import 'package:libraryapp/providers/home_provider.dart';
import 'package:libraryapp/screen/downloads.dart';
import 'package:libraryapp/screen/favorites.dart';
import 'package:libraryapp/util/consts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'account.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder:
        (BuildContext context, HomeProvider homeProvider, Widget child) {
      bool isLogin = homeProvider.isLogin;
      User currentUser = homeProvider.currentUser;
      List items = [
        {
          "icon": Feather.user,
          "title": !isLogin ? "Account" : "Hi, " + currentUser.email,
          "page": Account(),
        },
        {
          "icon": Feather.heart,
          "title": "Favorites",
          "page": Favorites(),
        },
        {
          "icon": Feather.download,
          "title": "Downloads",
          "page": Downloads(),
        },
        {"icon": Feather.moon, "title": "Dark Mode"},
      ];
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Settings",
          ),
        ),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            if (items[index]['title'] == "Dark Mode") {
              return SwitchListTile(
                secondary: Icon(
                  items[index]['icon'],
                ),
                title: Text(
                  items[index]['title'],
                ),
                value: Provider.of<AppProvider>(context).theme ==
                        Constants.lightTheme
                    ? false
                    : true,
                onChanged: (v) {
                  if (v) {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.darkTheme, "dark");
                  } else {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.lightTheme, "light");
                  }
                },
              );
            }

            return ListTile(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: items[index]['page'],
                    ),
                  ).then((value) {
                    if (value != null)
                      setState(() {
                        // currentUser = value;
                        // isLogin = value.email == null ? false : true;
                      });
                  });
                } else {
                  Provider.of<FavoritesProvider>(context, listen: false)
                      .getFeed();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: items[index]['page'],
                    ),
                  );
                }
              },
              leading: Icon(
                items[index]['icon'],
              ),
              title: Text(
                items[index]['title'],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      );
    });
  }
}
