import 'package:flutter/material.dart';
import 'package:libraryapp/providers/app_provider.dart';
import 'package:libraryapp/providers/details_provider.dart';
import 'package:libraryapp/providers/favorites_provider.dart';
import 'package:libraryapp/providers/home_provider.dart';
import 'package:libraryapp/providers/rental_provider.dart';
import 'package:libraryapp/screen/splash.dart';
import 'package:libraryapp/util/consts.dart';
import 'package:provider/provider.dart';

void main() {
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => RentalProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: appProvider.theme,
//          darkTheme: Constants.darkTheme,
          home: Splash(),
        );
      },
    );
  }
}
