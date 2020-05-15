import 'package:budbringer/services/authentication.dart';
import 'package:budbringer/utilities/color_const.dart';
import 'package:budbringer/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final scrollController = ScrollController();
  final mobileFocus = FocusNode();
  final otpFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String buttonText = 'Login';
  String verificationId;
  String otp;
  bool sendingOtp = false;
  _setVerificationId(id) {
    setState(() {
      verificationId = id;

      buttonText = 'Verify';
      sendingOtp = false;
    });
  }

  _handleButton(context) {
    if (_formKey.currentState.validate()) {
      if (buttonText == 'Login') {
        String phone = '+91' + _phoneController.text.trim();
        setState(() {
          if(mobileFocus.hasFocus)mobileFocus.unfocus();
          sendingOtp = true;
        });
        Auth.getOTP(phone, context, scrollController, _setVerificationId);
      } else {
        showDialog(context: context, child: CustomLoading());
        Auth.verifyOTP(_phoneController.text, context, otp, verificationId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Form(
      key: _formKey,
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
                          focusNode: mobileFocus,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            if (!sendingOtp) _handleButton(context);
                          },
                          validator: (term) => term.length != 10
                              ? '   * Enter a Valid Phone Number'
                              : null,
                          onFieldSubmitted: (term) {},
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[200])),
                              errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[200])),
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
                        width: width * 0.7,
                        child: PinCodeTextField(
                          textStyle:
                              GoogleFonts.mcLaren().copyWith(fontSize: 18),
                          backgroundColor: Color(0xfffafafa),
                          textInputType: TextInputType.number,
                          length: 6,
                          activeColor: primaryColor,
                          selectedColor: primaryColor,
                          inactiveColor: primaryColor,
                          obsecureText: false,
                          animationType: AnimationType.fade,
                          shape: PinCodeFieldShape.underline,
                          animationDuration: Duration(milliseconds: 200),
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
                if (!sendingOtp) _handleButton(context);
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
          sendingOtp
              ? Center(
                  child: Text(
                    '\nSending OTP ...',
                    style: GoogleFonts.mcLaren().copyWith(
                      color: Colors.pinkAccent,
                      fontSize: 12,
                    ),
                  ),
                )
              : Container(),
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
