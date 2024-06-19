import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ColorPalette {
  static const mainColor = Color(0xff0F1035);
  static const subColor = Color(0xff365486);
  static const whiteFloor = Color(0xffFAFAFA);
  static const greyFloor = Color(0xffF5F5F5);

//1DE9B6
}

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blackSizeHorizontal;
  static double? blackSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blackSizeHorizontal = screenWidth! / 100;
    blackSizeVertical = screenHeight! / 100;
  }
}


final mRobotoBold = GoogleFonts.roboto();
final mRobotoSemiBold = GoogleFonts.roboto(fontWeight: FontWeight.w600);
final mRobotoMedium = GoogleFonts.roboto(fontWeight: FontWeight.w500);
final mRobotoRegular = GoogleFonts.roboto(fontWeight: FontWeight.w200);

