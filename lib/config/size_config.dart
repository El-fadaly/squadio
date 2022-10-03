import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;
  static late double widthFactor;
  static late double heightFactor;
  static late double actualHeight;
  static dynamic padding;
  static late double aspectRatio;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    padding = _mediaQueryData.padding;
    actualHeight = screenHeight - padding.top - padding.bottom;
    heightFactor = screenHeight / 812.0;
    widthFactor = screenWidth / 375.0;
    aspectRatio = _mediaQueryData.size.aspectRatio;
    setOrientation();
  }

  static void setOrientation() {
    if (screenWidth > screenHeight) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]);
    }
  }

// Get the proportionate height as per screen size
  static double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = SizeConfig.screenHeight;
    // 812 is the layout height that designer use
    var height = (inputHeight / 812.0) * screenHeight;
    return height;
  }

// Get the proportionate height as per screen size
  static double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = SizeConfig.screenWidth;
    // 375 is the layout width that designer use
    var width = (inputWidth / 375.0) * screenWidth;
    return width;
  }

  static double getEquivalentFontSize(double fontSize) {
    var width = getProportionateScreenWidth(fontSize);
    return width;
  }
}
