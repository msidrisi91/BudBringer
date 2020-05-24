import 'package:budbringer/utilities/color_const.dart';
import 'package:budbringer/widgets/dp_dialog.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatefulWidget {
  ChatTile({this.index});
  final index;
  @override
  _ChatTileState createState() => _ChatTileState(index: index);
}

class _ChatTileState extends State<ChatTile> {
  _ChatTileState({this.index});
  final index;
  final List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(color: darkGrey, blurRadius: 2, offset: Offset(1, 1)),
  ];
  final heightRatio = 0.17;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width * 0.9,
          height: size.width * heightRatio,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      opaque: false,
                      barrierDismissible: true,
                      pageBuilder: (BuildContext context, _, __) =>
                          DPDialog(index: index),
                    ),
                  );
                },
                child: Hero(
                  tag: 'avatar$index',
                  child: Container(
                    height: size.width * heightRatio,
                    width: size.width * heightRatio,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: shadow,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: size.width * heightRatio,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  boxShadow: shadow,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
