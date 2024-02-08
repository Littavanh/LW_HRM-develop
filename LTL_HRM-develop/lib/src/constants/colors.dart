import 'package:flutter/material.dart';
// Map<int, Color> colorCodes = {// Green color code: FF93cd48MaterialColor customColor = MaterialColor(0xFF93cd48, colorCodes);

const dashBoardColor = Color.fromRGBO(105, 106, 183, 1);
Map<int, Color> splashScreenColorBottom = getColor(105, 106, 183);
const splashScreenColorTop = Color.fromRGBO(105, 106, 183, 1);
const white = Color(0xFFffffff);
const appbarcolor1 = Color.fromRGBO(51, 51, 102, 1);
const appbarcolor = Color(0xFFE1BEE7);
const leaveCardcolor = Color.fromRGBO(36, 80, 144, 1);

const leaveCardcolor1 = Color(0xFF264575);
const kGreyLightColor = Colors.grey;
const kPrimaryColor = Color.fromRGBO(36, 80, 144, 1);
const kWhiteColor = Colors.white;
const kRedColor = Colors.red;

getColor(red, green, blue) {
  return {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };
}
