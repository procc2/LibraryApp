// import 'package:flutter/material.dart';
// import 'package:libraryapp/util/consts.dart';

// class FilterDrawer extends StatefulWidget {
//   FilterDrawer(dynamic allCategory){
//       List categories = allCategory;
//   }
//   @override
//   _FilterDrawerState createState() => _FilterDrawerState();
// }

// class _FilterDrawerState extends State<FilterDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: <Widget>[
//                 Container(
//                   height: 100,
//                   child: DrawerHeader(
//                     child: Text('Filter'),
//                     decoration: BoxDecoration(
//                       color: Constants.darkAccent,
//                     ),
//                   ),
//                 ),
//                 Hero(
//                   tag: "Category",
//                   child: Material(
//                     type: MaterialType.transparency,
//                     child: Text(
//                       "Category",
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   // height: homeProvider.categories.feed.length < 3 ? 40 : 80,
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: categories.feed.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 210 / 80,
//                     ),
//                     itemBuilder: (BuildContext context, int index) {
//                       EntryCategory cat = homeProvider.categories.feed[index];
//                       // Category cat = entry.category[index];
//                       return Padding(
//                         padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).backgroundColor,
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(20),
//                             ),
//                             border: Border.all(
//                               color: Theme.of(context).accentColor,
//                             ),
//                           ),
//                           child: Center(
//                             child: InkWell(
//                               child: Text(
//                                 "${cat.name}",
//                                 style: TextStyle(
//                                   color: Theme.of(context).accentColor,
//                                   fontSize: cat.name.length > 18 ? 6 : 10,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               onTap: (){
                                
//                               },
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
// }