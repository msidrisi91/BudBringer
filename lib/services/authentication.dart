import 'package:budbringer/screens/login.dart';
import 'package:budbringer/screens/newUserSignUp.dart';
import 'package:budbringer/screens/userlist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final _codeController = TextEditingController();
  final _firestore = Firestore.instance;

  void userNotNull(BuildContext context, AuthResult result, phone) {
    FirebaseUser user = result.user;
    if (user != null) {
      print('This is a new user $result.additionalUserInfo.isNewUser');
      if (result.additionalUserInfo.isNewUser) {
        _firestore.collection('/users').document(user.uid).setData({
          'name': '',
          'phoneNumber': phone,
          'profileImageUrl': '',
          'chattingWith': null,
          'unreadmessagecount': 0,
        });
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NewUserSignUp(
                      user: user,
                    )));
      } else {
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NewUserSignUp(
                      user: user,
                    )));
      
        // Navigator.of(context).pop();
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => UserList(
        //               currentUserId: user.uid,
        //             ))
        //             );
      }
    } else {
      print("Error");
    }
  }
  // void getOTP(String phone, BuildContext context){
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   _auth.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       timeout: Duration(seconds: 60),
  //       verificationCompleted: (AuthCredential credential) async {
  //         AuthResult result = await _auth.signInWithCredential(credential);
  //         userNotNull(context, result, phone);
  //         //This callback would gets called when verification is done automaticlly
  //       },
  //       verificationFailed: (AuthException exception) {
  //         print(exception.message);
  //       },
  //       // codeSent: (_,_){},
  //       codeAutoRetrievalTimeout: null);
  // }
  // }
  void loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          userNotNull(context, result, phone);
          //This callback would gets called when verification is done automaticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);
                        Navigator.of(context).pop();
                        userNotNull(context, result, phone);
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  static void logout(context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
