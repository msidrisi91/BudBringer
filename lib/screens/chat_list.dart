import 'package:budbringer/utilities/color_const.dart';
import 'package:budbringer/widgets/chatlist_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        width: size.width,
        height: size.height - kToolbarHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(color: darkGrey, blurRadius: 5),
          ],
        ),
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Chats',
              textAlign: TextAlign.center,
              style: GoogleFonts.mcLaren()
                  .copyWith(color: darkGrey, fontSize: size.width * 0.06),
            ),
          ),
          Divider(),
          Container(
            width: size.width,
            height: size.height - kToolbarHeight - size.width * 0.26,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ChatTile(
                  index: index,
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
