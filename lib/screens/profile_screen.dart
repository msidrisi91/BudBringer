// import 'package:budbringer/services/authentication.dart';
// import 'package:budbringer/services/databaseservice.dart';
// import 'package:budbringer/utilities/color_const.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProfileScreen extends StatefulWidget {
//   ProfileScreen({this.uid});
//   final String uid;
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState(uid: uid);
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   _ProfileScreenState({this.uid});
//   final String uid;
//   var user;
//   _getUser() async {
//     await DatabaseService.getUserWithId(uid).then((value) {
//       print(value.phoneNumber);
//       print(value.name);
//       setState(() {
//         user = value;
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final List<BoxShadow> shadow = <BoxShadow>[
//       BoxShadow(color: darkGrey, blurRadius: 2, offset: Offset(1, 1)),
//     ];
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           CachedNetworkImage(
//             imageUrl: user != null && user.profileImageUrl != null
//                 ? user.profileImageUrl
//                 : '',
//             placeholder: (context, url) => Container(
//               width: size.width,
//               height: size.width,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(32),
//                   bottomRight: Radius.circular(32),
//                 ),
//               ),
//               child: Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//                   strokeWidth: 2.00,
//                   backgroundColor: Colors.grey[200],
//                 ),
//               ),
//             ),
//             errorWidget: (context, url, error) => Container(
//               width: size.width,
//               height: size.width,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image:
//                       Image.asset('assets/images/user_placeholder.jpg').image,
//                   fit: BoxFit.fill,
//                 ),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(32),
//                   bottomRight: Radius.circular(32),
//                 ),
//               ),
//             ),
//             imageBuilder: (BuildContext context, ImageProvider image) {
//               return Container(
//                 width: size.width,
//                 height: size.width,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: image,
//                     fit: BoxFit.fill,
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(32),
//                     bottomRight: Radius.circular(32),
//                   ),
//                 ),
//               );
//             },
//           ),
//           SizedBox(
//             height: size.height * 0.08,
//           ),
//           Container(
//             height: size.height * 0.12,
//             width: size.width * 0.9,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12.0),
//               color: Colors.white,
//               boxShadow: shadow,
//             ),
//             child: Center(
//               child: Text(
//                 user != null && user.phoneNumber != null
//                     ? user.phoneNumber
//                     : '',
//                 style: GoogleFonts.mcLaren()
//                     .copyWith(color: darkGrey, fontSize: size.width * 0.06),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: size.height * 0.08,
//           ),
//           GestureDetector(
//             onTap: () {
//               Auth.logout(context);
//             },
//             child: Container(
//               height: size.height * 0.1,
//               width: size.width * 0.9,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.0),
//                 color: Colors.blueAccent,
//                 boxShadow: shadow,
//               ),
//               child: Center(
//                 child: Text(
//                   'Log Out',
//                   style: GoogleFonts.mcLaren().copyWith(
//                       color: Colors.white, fontSize: size.width * 0.06),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:budbringer/services/authentication.dart';
import 'package:budbringer/services/databaseservice.dart';
import 'package:budbringer/utilities/color_const.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({this.uid});
  final String uid;
  @override
  _ProfileScreenState createState() => _ProfileScreenState(uid: uid);
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState({this.uid});
  final String uid;
  var user;
  _getUser() async {
    await DatabaseService.getUserWithId(uid).then((value) {
      print(value.phoneNumber);
      print(value.name);
      setState(() {
        user = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<BoxShadow> shadow = <BoxShadow>[
      BoxShadow(color: darkGrey, blurRadius: 2, offset: Offset(1, 1)),
    ];
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              // shape: ContinuousRectangleBorder(
              //   borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(63),
              //     bottomRight: Radius.circular(63),
              //   ),
              // ),
              expandedHeight: size.width,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                // centerTitle: true,
                title: Text(
                  user != null ? user.name : '',
                  style: GoogleFonts.mcLaren().copyWith(
                      color: Colors.black, fontSize: size.width * 0.06),
                ),
                background: CachedNetworkImage(
                  imageUrl: user != null && user.profileImageUrl != null
                      ? user.profileImageUrl
                      : '',
                  placeholder: (context, url) => Container(
                    width: size.width,
                    height: size.width,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(30),
                    //     bottomRight: Radius.circular(30),
                    //   ),
                    // ),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                        strokeWidth: 2.00,
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: size.width,
                    height: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset('assets/images/user_placeholder.jpg')
                            .image,
                        fit: BoxFit.fill,
                      ),
                      // borderRadius: BorderRadius.only(
                      //   bottomLeft: Radius.circular(30),
                      //   bottomRight: Radius.circular(30),
                      // ),
                    ),
                  ),
                  imageBuilder: (BuildContext context, ImageProvider image) {
                    return Container(
                      width: size.width,
                      height: size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.fill,
                        ),
                        // borderRadius: BorderRadius.only(
                        //   bottomLeft: Radius.circular(30),
                        //   bottomRight: Radius.circular(30),
                        // ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.08,
            ),
            Container(
              height: size.height * 0.12,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: shadow,
              ),
              child: Center(
                child: Text(
                  user != null && user.phoneNumber != null
                      ? user.phoneNumber
                      : '',
                  style: GoogleFonts.mcLaren()
                      .copyWith(color: darkGrey, fontSize: size.width * 0.06),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            GestureDetector(
              onTap: () {
                Auth.logout(context);
              },
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.blueAccent,
                  boxShadow: shadow,
                ),
                child: Center(
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.mcLaren().copyWith(
                        color: Colors.white, fontSize: size.width * 0.06),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
