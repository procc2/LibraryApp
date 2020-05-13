import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:libraryapp/podo/category.dart';
import 'package:libraryapp/providers/details_provider.dart';
import 'package:libraryapp/providers/favorites_provider.dart';
import 'package:libraryapp/screen/details.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BookItem extends StatelessWidget {
  final String img;
  final String title;
  final Entry entry;
  final bool isRentalPage;

  BookItem({
    Key key,
    @required this.img,
    @required this.title,
    @required this.entry, 
    this.isRentalPage,
  }) : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<DetailsProvider>(context, listen: false).setEntry(entry);
        // Provider.of<DetailsProvider>(context, listen: false).getFeed(entry.author.uri.t);
        Provider.of<DetailsProvider>(context, listen: false).getFeed();
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: Details(
              entry: entry,
              imgTag: imgTag,
              titleTag: titleTag,
              authorTag: authorTag,
            ),
          ),
        ).then((v){
          Provider.of<FavoritesProvider>(context, listen: false).getFeed();
        });
      },
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Hero(
              tag: imgTag,
              child: CachedNetworkImage(
                imageUrl: "$img",
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/place.png",
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
          ),

          SizedBox(height: 5,),

          Hero(
            tag: titleTag,
            child: Text(
              "${title.replaceAll(r"\", "")}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          isRentalPage ? 
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child:  Text(
              entry.rentalDay.difference(DateTime.now()).inDays > 0 ?"${entry.rentalDay.difference(DateTime.now()).inDays} days left" : "over ${DateTime.now().difference(entry.rentalDay).inDays} day ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
          : Container(
            height: 0,width: 0,
          ),
        ],
      ),
    );
  }
}
