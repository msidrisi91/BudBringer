import 'package:budbringer/screens/chat_list.dart';
import 'package:budbringer/screens/moments.dart';
import 'package:budbringer/utilities/color_const.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
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
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.account_circle)),
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
                  color: index == 1 ? Colors.white :  Colors.pink[50]))
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
