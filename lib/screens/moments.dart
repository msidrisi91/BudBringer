import 'package:budbringer/utilities/color_const.dart';
import 'package:flutter/material.dart';

class MomentsScreen extends StatefulWidget {
  @override
  _MomentsScreenState createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,10,0,0),
      child: Container(
        width: size.width,
        height: size.height - kToolbarHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(color: darkGrey, blurRadius: 5, offset: Offset(8, 0),),
          ],
        ),
      ),
    );
  }
}
