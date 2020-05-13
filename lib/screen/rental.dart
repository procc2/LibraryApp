import 'package:flutter/material.dart';
import 'package:libraryapp/podo/category.dart';
import 'package:libraryapp/providers/rental_provider.dart';
import 'package:libraryapp/widgets/book.dart';
import 'package:provider/provider.dart';

class Rental extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RentalProvider>(
      builder:
          (BuildContext context, RentalProvider rentalProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Rental",
            ),
          ),
          body: rentalProvider.isLoading()
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : rentalProvider.posts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
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
                      itemCount: rentalProvider.posts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 200 / 340,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        Entry entry = rentalProvider.posts[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: BookItem(
                              img: entry.files.isNotEmpty ? entry.files.single.title : null,
                              title: entry.title.t,
                              entry: entry,
                              isRentalPage: true),
                        );
                      },
                    ),
        );
      },
    );
  }
}
