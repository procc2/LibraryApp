import 'package:flutter/material.dart';
import 'package:libraryapp/providers/app_provider.dart';
import 'package:libraryapp/providers/favorites_provider.dart';
import 'package:libraryapp/providers/home_provider.dart';
import 'package:libraryapp/providers/rental_provider.dart';
import 'package:libraryapp/util/consts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';

import 'favorites.dart';
import 'rental.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder:
        (BuildContext context, HomeProvider homeProvider, Widget child) {
      if (homeProvider.isLogin) {
        List items = [
          {
            "icon": Feather.mail,
            "title": homeProvider.currentUser.email,
            // "page": Account(),
          },
          {
            "icon": Feather.heart,
            "title": "Favorites",
            "page": Favorites(),
          },
          {
            "icon": Feather.book_open,
            "title": "Rental",
            "page": Rental(),
          },
          // {"icon": Feather.moon, "title": "Dark Mode"},
        ];
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Information",
              ),
            ),
            body: Column(children: <Widget>[
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Provider.of<RentalProvider>(context, listen: false)
                          .getFeed();
                      if (items[index]['title'] == "Rental") {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: items[index]['page'],
                          ),
                        );
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
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                  child: SizedBox(
                    height: 40.0,
                    child: new RaisedButton(
                        elevation: 5.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Provider.of<AppProvider>(context).theme ==
                                Constants.lightTheme
                            ? Colors.redAccent
                            : Theme.of(context).dialogBackgroundColor,
                        child: new Text('Logout',
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white)),
                        onPressed: () {
                          homeProvider.logout();
                          Navigator.pop(context, homeProvider.currentUser);
                        }),
                  )),
            ]));
      } else {
        final _formKey = new GlobalKey<FormState>();
        var _email =
            TextEditingController(text: homeProvider.currentUser.email);
        var _password =
            TextEditingController(text: homeProvider.currentUser.password);
        return homeProvider.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    "Login",
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                          child: new TextFormField(
                            maxLines: 1,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            decoration: new InputDecoration(
                                hintText: 'Email',
                                icon: new Icon(
                                  Feather.mail,
                                  color: Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                    icon: new Icon(
                                      Feather.x_circle,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (_) => _email.clear());
                                    })),
                            validator: (value) =>
                                value.isEmpty ? 'Email can\'t be empty' : null,
                            onSaved: (value) =>
                                homeProvider.currentUser.email = value.trim(),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        child: new TextFormField(
                          maxLines: 1,
                          obscureText: true,
                          controller: _password,
                          autofocus: false,
                          decoration: new InputDecoration(
                              hintText: 'Password',
                              icon: new Icon(
                                Feather.lock,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                  icon: new Icon(
                                    Feather.x_circle,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback(
                                            (_) => _password.clear());
                                  })),
                          validator: ((value) {
                            if (value.isEmpty)
                              return 'Password can\'t be empty';
                            else if (value.length <= 4)
                              return 'Please enter a password between 5-20 characters long (numbers and letters only)';
                            else
                              return null;
                          }),
                          onSaved: (value) =>
                              homeProvider.currentUser.password = value.trim(),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 35.0, 10.0, 0.0),
                          child: SizedBox(
                            height: 40.0,
                            child: new RaisedButton(
                                elevation: 5.0,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Theme.of(context).accentColor,
                                child: new Text('Login',
                                    style: new TextStyle(
                                        fontSize: 20.0, color: Colors.white)),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    await homeProvider
                                        .validateAndSubmit()
                                        .then((isLogin) {
                                      if (isLogin)
                                        Navigator.pop(
                                            context, homeProvider.currentUser);
                                    });
                                  }
                                }),
                          )),
                    ],
                  ),
                ));
      }
    });
  }
}
