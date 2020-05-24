import 'package:budbringer/screens/chat_list.dart';
import 'package:budbringer/screens/moments.dart';
import 'package:budbringer/screens/profile_screen.dart';
import 'package:budbringer/utilities/color_const.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  FirebaseUser user;
  int index = 0;
  void _getUser() async {
    await FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  Route _routeToProfile() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ProfileScreen(uid: user.uid),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, -1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                index = 0;
              });
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 400), curve: Curves.easeIn);
            },
            child: Text(
              'BudBringer',
              style: TextStyle(
                color: index == 0 ? Colors.white : Colors.pink[50],
                fontFamily: 'Billabong',
                fontSize: size.width * 0.1,
              ),
            ),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(_routeToProfile());
            },
            icon: Icon(Icons.account_circle)),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  index = 1;
                });
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeIn);
              },
              icon: Icon(Icons.camera_roll,
                  color: index == 1 ? Colors.white : Colors.pink[50]))
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[Chats(), MomentsScreen()],
        onPageChanged: (i) {
          setState(() {
            index = i;
          });
        },
      ),
    );
  }
}
