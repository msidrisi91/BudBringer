// import 'package:budbringer/services/authentication.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatelessWidget {
//   final _phoneController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.all(32),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 "Login",
//                 style: TextStyle(
//                     color: Colors.lightBlue,
//                     fontSize: 36,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                         borderSide: BorderSide(color: Colors.grey[200])),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                         borderSide: BorderSide(color: Colors.grey[300])),
//                     filled: true,
//                     fillColor: Colors.grey[100],
//                     hintText: "Mobile Number"),
//                 controller: _phoneController,
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Container(
//                 width: double.infinity,
//                 child: FlatButton(
//                   child: Text("LOGIN"),
//                   textColor: Colors.white,
//                   padding: EdgeInsets.all(16),
//                   onPressed: () {
//                     final phone = _phoneController.text.trim();
//                     if (phone != '' && phone != null) {
//                       Auth().loginUser(phone, context);
//                     } else {
//                       final snackbar = SnackBar(
//                         content: Text('Enter A Phone Number'),
//                         duration: Duration(seconds: 5),
//                       );
//                       Scaffold.of(context).showSnackBar(snackbar);
//                     }
//                   },
//                   color: Colors.blue,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
import 'package:budbringer/services/authentication.dart';
import 'package:budbringer/utilities/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  String buttonText = 'Login';

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final scrollController = ScrollController();
    String otp;
    return Scaffold(
        body: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: height * 0.5,
            width: width,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(46),
                      bottomRight: Radius.circular(46),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/loginpage.jpg'),
                      fit: BoxFit.fitWidth,
                    ),
                    
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      'BudBringer',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Billabong',
                        fontSize: width * 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Container(
              height: height * 0.15,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 32, left: 32),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          onFieldSubmitted: (term) {},
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[200])),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300])),
                              filled: true,
                              prefixText: '+91 ',
                              prefixIcon: Icon(Icons.phone),
                              fillColor: Colors.grey[100],
                              hintText: "Mobile Number"),
                          controller: _phoneController,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    child: Center(
                      child: Container(
                        width: width * 0.5,
                        child: PinCodeTextField(
                          textStyle:
                              GoogleFonts.mcLaren().copyWith(fontSize: 18),
                          backgroundColor: Color(0xfffafafa),
                          textInputType: TextInputType.number,
                          length: 4,
                          activeColor: primaryColor,
                          selectedColor: primaryColor,
                          inactiveColor: primaryColor,
                          obsecureText: false,
                          animationType: AnimationType.fade,
                          shape: PinCodeFieldShape.box,
                          animationDuration: Duration(milliseconds: 300),
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 45,
                          fieldWidth: 45,
                          onChanged: (value) {
                            setState(() {
                              otp = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                // final phone = _phoneController.text.trim();
                // if (phone != '' && phone != null) {
                //   // Auth().loginUser(phone, context);
                //   print('Proceed to OTP');
                // } else {
                //   final snackbar = SnackBar(
                //     content: Text('Enter A Phone Number'),
                //     duration: Duration(seconds: 5),
                //   );
                //   Scaffold.of(context).showSnackBar(snackbar);
                // }
                if (buttonText == 'Login') {
                  scrollController.animateTo(MediaQuery.of(context).size.width,
                      duration: Duration(milliseconds: 678),
                      curve: Curves.ease);
                  setState(() {
                    buttonText = 'Verify';
                  });
                }
              },
              child: Container(
                width: width * 0.4,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        offset: Offset(0, 6),
                        blurRadius: 20,
                        spreadRadius: 0)
                  ],
                  // #FDD9DC
                  color: primaryColor,
                ),
                child: Center(
                  child: Text(
                    buttonText,
                    style: GoogleFonts.mcLaren().copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          buttonText == 'Login'
              ? Container()
              : Center(
                  child: FlatButton(
                    child: Text(
                      'Change Phone Number',
                      style: GoogleFonts.mcLaren().copyWith(
                        color: Colors.pinkAccent,
                        fontSize: 12,
                      ),
                    ),
                    onPressed: () {
                      scrollController.animateTo(0,
                          duration: Duration(milliseconds: 678),
                          curve: Curves.ease);
                      setState(() {
                        buttonText = 'Login';
                      });
                    },
                  ),
                ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: height * 0.05, left: width * 0.05, right: width * 0.05),
            child: Text(
              'Did I ever tell you about the time I went backpacking through Western Europe?',
              textAlign: TextAlign.center,
              style: GoogleFonts.mcLaren().copyWith(
                color: primaryColor,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
