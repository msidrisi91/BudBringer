import 'package:budbringer/screens/home_screen.dart';
import 'package:budbringer/screens/sign_up.dart';
import 'package:budbringer/services/databaseservice.dart';
import 'package:budbringer/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';

class LoggedInScreens extends StatefulWidget {
  LoggedInScreens({this.uid});
  final uid;
  @override
  _LoggedInScreensState createState() => _LoggedInScreensState(uid: uid);
}

class _LoggedInScreensState extends State<LoggedInScreens> {
  _LoggedInScreensState({this.uid});
  final uid;
  @override
  Widget build(BuildContext context) {
    print('uid reached: $uid');
    return FutureBuilder(
      future: DatabaseService.isDataFilled(uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: CustomLoading());
        } else {
          if (snapshot.data) {
            return HomeScreen();
          } else {
            return NewUserSignUp();
          }
        }
      },
    );
  }
}
