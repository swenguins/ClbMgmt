import 'package:flutter/widgets.dart';

///This class configures the screen into 100x100 pixel grids.
///This is allows two crucial functions to be achieved.
///1. Allows flexibility and scalability with different screen sizes.
///2. Allows you to easily and precisely adjust a Widgets screen position.
///This code was sourced from this article if you want to read into it further.
///https://medium.com/flutter-community/flutter-effectively-scale-ui-according-to-different-screen-sizes-2cb7c115ea0a
///Todo: When sizing any Widget, Text, or Padding use the functions of this file
///Rather than using specific, hard coded values. To initialize this class in any
///file in the Widget's build function use this line 'SizeConfig().init(context);'
/// - JK 2/28

class SizeConfig {

  ///Define properties to hold screen size values and data.
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  ///Define variables to hold safe area values and data.
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  ///Define a constant block size for grid pattern 100x100 pixels.
  static final double blockSize = 100.0;

  ///Constructor to initialize screen size and safe area values.
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / blockSize;
    blockSizeVertical = screenHeight / blockSize;

    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth  - _safeAreaHorizontal) / blockSize;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / blockSize;
  }

}