import 'package:budbringer/utilities/color_const.dart';
import 'package:flutter/material.dart';

// Widget dpDialog(width, context) {
//   final List<BoxShadow> shadow = <BoxShadow>[
//     BoxShadow(color: darkGrey, blurRadius: 2, offset: Offset(1, 1)),
//   ];
//   return Scaffold(
//     body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Hero(
//           tag: 'avatar',
//           child: Container(
//             height: width * 0.7,
//             width: width * 0.7,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12.0),
//               boxShadow: shadow,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
class DPDialog extends StatelessWidget {
  DPDialog({this.index});
  final index;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<BoxShadow> shadow = <BoxShadow>[
      BoxShadow(color: darkGrey, blurRadius: 2, offset: Offset(1, 1)),
    ];
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        color: Colors.black.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Hero(
                tag: 'avatar$index',
                child: Container(
                  height: size.width * 0.7,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.0),
                    boxShadow: shadow,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: size.width * 0.15,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.0),
                    boxShadow: shadow,
                  ),
                  child: Icon(Icons.message, color: darkGrey, size: 32),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
