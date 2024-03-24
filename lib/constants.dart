import 'dart:io';
import 'dart:ui';

final String slash = Platform.pathSeparator;
const List<String> excludePrefixes = ['__', '.'];
const List<String> indexingSymbols = [
  ' - ',
  '. ',
  ' ',
  '_',
  '. - ',
  '-',
  ') ',
  '.) '
];

class AppColor {
  static const Color ceruleanBlue = Color(0xFF007BA7);
  static const Color lavenderPurple = Color(0xFF967BB6);
  static const Color emeraldGreen = Color(0xFF50C878);
  static const Color rosePink = Color(0xFFFF007F);
  static const Color sapphireBlue = Color(0xFF0F52BA);
  static const Color coralPink = Color(0xFFFF6F61);
  static const Color goldenYellow = Color(0xFFF9A602);
  static const Color amethystPurple = Color(0xFF884DA7);
  static const Color mintGreen = Color(0xFF98FF98);
  static const Color tangerineOrange = Color(0xFFFFA500);
  static const Color rubyRed = Color(0xFFE0115F);
  static const Color crimsonRed = Color(0xFFDC143C);
  static const Color scarletRed = Color(0xFFFF2400);
  static const Color lightRubyRed = Color(0xFFFF6090);
  static const Color lightCrimsonRed = Color(0xFFFF6F7A);
  static const Color lightScarletRed = Color(0xFFFF7264);
}
