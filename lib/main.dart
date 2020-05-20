import 'package:budbringer/screens/home_screen.dart';
import 'package:budbringer/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('BudBringer', style: TextStyle(fontSize: 40)),
                  CircularProgressIndicator()
                ],
              ),
            )),
          );
        } else {
          if (snapshot.hasData && snapshot.data.uid != null) {
            print(snapshot.data.uid);
            return HomeScreen();
          } else {
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
      home: _getScreenId(),
    );
  }
}
