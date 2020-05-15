import 'dart:ui';

final themeColor = Color(0xfff5a623);
final primaryColor = hexToColor('#FABDD4');
final shadowColor = hexToColor('#FDD9DC');
final darkGrey = hexToColor('#515151');
final greyColor = Color(0xffaeaeae);
final greyColor2 = Color(0xffE8E8E8);

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
