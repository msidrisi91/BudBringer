import 'package:budbringer/models/user_model.dart';
import 'package:budbringer/services/databaseservice.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    final _user = await DatabaseService.getUserWithId(uid);
    setState(() {
      user = _user;
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: <Widget>[
        CachedNetworkImage(
          imageUrl: user.profileImageUrl,
          placeholder: (context, url) => Container(
            height: 30.0,
            width: 30.0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
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
                image: Image.asset('assets/images/user_placeholder.jpg').image,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
            );
          },
        )
      ]),
    );
  }
}
