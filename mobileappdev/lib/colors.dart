import 'package:flutter/material.dart';

///This file defines the values used for the color scheme of the application.
///The primaryBase Blue was chosen due to it's legibility with both White
///and Black text, which ameliorates some accessibility issues with the old
///Teal and Black theme. For flexibility in color choice due to the
///different needs for each screen you can include this file to 'override' the.
///Theme set in main.dart However, for consistency and to retain accessibility
///I strongly recommend to not go outside this color scheme for any major
///background, button, label or text colors. To set a color in another
///file simply use the line 'import 'colors.dart';' to include it in the file.
/// - JK 2/28

///Base light color more legiable with Black text.
const primaryLight = const Color(0xFF63A4FF);

///Base color legible with both White and Black text.
const primaryBase = const Color(0xFF1976D2);

///Base dark color more legiable with White text.
const primaryDark = const Color(0xFF004BA0);

///Accent and error colors.
const accent = const Color(0xFFFF9800);
const errorRed = const Color(0xFFC5032B);

///Surface white is used for whites other than the background.
const surfaceWhite = const Color(0xFFFFFBFA);

///The color used for the background.
const backgroundWhite = const Color(0xFFFFFFFF);