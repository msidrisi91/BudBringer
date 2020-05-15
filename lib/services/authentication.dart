import 'package:budbringer/screens/login.dart';
import 'package:budbringer/screens/sign_up.dart';
import 'package:budbringer/screens/userlist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  static final _firestore = Firestore.instance;

  static FirebaseAuth _auth = FirebaseAuth.instance;

  static void userNotNull(BuildContext context, AuthResult result, phone) {
    FirebaseUser user = result.user;
    if (user != null) {
      print('This is a new user ${result.additionalUserInfo.isNewUser}');
      Navigator.of(context).pop();
      if (result.additionalUserInfo.isNewUser) {
        _firestore.collection('/users').document(user.uid).setData({
          'name': '',
          'phoneNumber': phone,
          'profileImageUrl': '',
          'chattingWith': null,
          'unreadmessagecount': 0,
        });

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Center(
        //       child: RaisedButton(
        //         child: Text('Log Out'),
        //         onPressed: () {
        //           logout(context);
        //         },
        //       ),
        //     ),
        //   ),
        // );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NewUserSignUp(
              user: user,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NewUserSignUp(
              user: user,
            ),
          ),
        );

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Center(
        //       child: RaisedButton(
        //         child: Text('Log Out'),
        //         onPressed: () {
        //           logout(context);
        //         },
        //       ),
        //     ),
        //   ),
        // );
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

  static void verifyOTP(String phone, BuildContext context, String otp,
      String verificationId) async {
    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: otp);

    AuthResult result = await _auth.signInWithCredential(credential);
    userNotNull(context, result, phone);
  }

  static void getOTP(String phone, BuildContext context,
      ScrollController controller, setVerificationId) {
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
          controller.animateTo(MediaQuery.of(context).size.width,
              duration: Duration(milliseconds: 678), curve: Curves.ease);
          setVerificationId(verificationId);
        },
        codeAutoRetrievalTimeout: null);
  }

  static void logout(context) {
    _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
