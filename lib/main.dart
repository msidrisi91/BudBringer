import 'package:budbringer/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budbringer/screens/userlist.dart';

// import 'package:budbringer/screens/newUserSignUp.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
                child: Container(
              child: Column(
                children: <Widget>[
                  Text('BudBringer', style: TextStyle(fontSize: 40)),
                  CircularProgressIndicator()
                ],
              ),
            )),
          );
        } else {
          if (snapshot.hasData) {
            return UserList(currentUserId: snapshot.data.uid);
          } else {
            print(snapshot);
            return LoginScreen();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BudBringer',
      themeMode: ThemeMode.dark,
      theme: ThemeData(primaryColor: Color(0xFFBC3358)),
      home: 
      _getScreenId(),
    );
  }
}