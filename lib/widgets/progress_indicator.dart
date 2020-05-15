import 'package:budbringer/utilities/color_const.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatefulWidget {
  @override
  _CustomLoadingState createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> with TickerProviderStateMixin{
  final style = TextStyle(fontFamily: 'PierSans', fontSize: 14.0);
  AnimationController _animationController;
  var _colorTween;
  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(milliseconds:700));
    _colorTween = _animationController.drive(ColorTween(begin: Colors.pinkAccent, end: primaryColor));
    _animationController.repeat();
    super.initState();
  }
  @override
  void dispose(){
    _animationController.stop();
    super.dispose();
  }
   @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(
            valueColor: _colorTween,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '  Loading...',
          style: style.copyWith(fontSize: 14, color: darkGrey),
        )
      ],
    );
  }
}
