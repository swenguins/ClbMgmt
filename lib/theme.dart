import 'package:flutter/material.dart';

///This file was created using panache, which is in beta, but helps you create
///themes. However, I'd like to modify a lot of the values for specific fields,
///specifically text and button color fields. I need to look though all of this
///just to see what fields apply to what Widgets. I would like to use this file
///rather than colors.dart when selecting colors for Widgets because a call to
///this file is a lot more readable than the current implementation.
///ex: Theme.of(context).primaryColor <- typical call to set a color.
///This is set as the theme in main.dart and was of course made its own file due
///to its size - JK 2/28


final ThemeData clubManagementAppTheme = _buildClubManagementAppTheme();

ThemeData _buildClubManagementAppTheme() {
  final ThemeData base = ThemeData(
    primarySwatch:  MaterialColor(4279858898, {
      50: Color(0xffe8f2fc), 100: Color(0xffd1e6fa), 200: Color(0xffa4ccf4),
      300: Color(0xff76b3ef), 400: Color(0xff4999e9), 500: Color(0xff1b80e4),
      600: Color(0xff1666b6), 700: Color(0xff104d89), 800: Color(0xff0b335b)
      , 900: Color(0xff051a2e)}),
  );

  return base.copyWith(
    brightness: Brightness.light,
    primaryColor: Color( 0xff1976d2 ),
    primaryColorBrightness: Brightness.light,
    primaryColorLight: Color( 0xffbbdefb ),
    primaryColorDark: Color( 0xff004ba0 ),
    accentColor: Color( 0xffff9800 ),
    accentColorBrightness: Brightness.light,
    canvasColor: Color( 0xfffafafa ),
    scaffoldBackgroundColor: Color( 0xfffafafa ),
    bottomAppBarColor: Color( 0xffffffff ),
    cardColor: Color( 0xffffffff ),
    dividerColor: Color( 0x1f000000 ),
    highlightColor: Color( 0x66bcbcbc ),
    splashColor: Color( 0x66c8c8c8 ),
    selectedRowColor: Color( 0xfff5f5f5 ),
    unselectedWidgetColor: Color( 0x8a000000 ),
    disabledColor: Color( 0x61000000 ),
    buttonColor: Color( 0xff1976d2 ),
    toggleableActiveColor: Color( 0xff1e88e5 ),
    secondaryHeaderColor: Color( 0xffe3f2fd ),
    textSelectionColor: Color( 0xff90caf9 ),
    cursorColor: Color( 0xff4285f4 ),
    textSelectionHandleColor: Color( 0xff64b5f6 ),
    backgroundColor: Color( 0xff90caf9 ),
    dialogBackgroundColor: Color( 0xffffffff ),
    indicatorColor: Color( 0xff2196f3 ),
    hintColor: Color( 0x8a000000 ),
    errorColor: Color( 0xffd32f2f ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      minWidth: 100,
      height: 36,
      padding: EdgeInsets.only(top:0,bottom:0,left:32, right:32),
      shape: StadiumBorder( side: BorderSide(color: Color( 0xff000000 ), width: 0, style: BorderStyle.none, ) ) ,
      alignedDropdown: true ,
      buttonColor: Color( 0xff1976d2 ),
      disabledColor: Color( 0x61000000 ),
      highlightColor: Color( 0x29000000 ),
      splashColor: Color( 0x1f000000 ),
      focusColor: Color( 0x1f000000 ),
      hoverColor: Color( 0x0a000000 ),
      colorScheme: ColorScheme(
        primary: Color( 0xff2196f3 ),
        primaryVariant: Color( 0xff1976d2 ),
        secondary: Color( 0xff2196f3 ),
        secondaryVariant: Color( 0xff1976d2 ),
        surface: Color( 0xffffffff ),
        background: Color( 0xff90caf9 ),
        error: Color( 0xffd32f2f ),
        onPrimary: Color( 0xffffffff ),
        onSecondary: Color( 0xffffffff ),
        onSurface: Color( 0xff000000 ),
        onBackground: Color( 0xffffffff ),
        onError: Color( 0xffffffff ),
        brightness: Brightness.light,
      ),
    ),
    textTheme: TextTheme(
      display4: TextStyle(
        color: Color( 0x8a000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      display3: TextStyle(
        color: Color( 0x8a000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      display2: TextStyle(
        color: Color( 0x8a000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      display1: TextStyle(
        color: Color( 0x8a000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headline: TextStyle(
        color: Color( 0xdd000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      title: TextStyle(
        color: Color( 0xdd000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      subhead: TextStyle(
        color: Color( 0xdd000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      body2: TextStyle(
        color: Color( 0xdd000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      body1: TextStyle(
        color: Color( 0xdd000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      caption: TextStyle(
        color: Color( 0x8a000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      button: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      subtitle: TextStyle(
        color: Color( 0xff000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      overline: TextStyle(
        color: Color( 0xff000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ).apply(
      fontFamily: 'OpenSans',
    ),
    primaryTextTheme: TextTheme(
      display4: TextStyle(
        color: Color( 0xb3ffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      display3: TextStyle(
        color: Color( 0xb3ffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      display2: TextStyle(
        color: Color( 0xb3ffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      display1: TextStyle(
        color: Color( 0xb3ffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headline: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      title: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      subhead: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      body2: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      body1: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      caption: TextStyle(
        color: Color( 0xb3ffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      button: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      subtitle: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      overline: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ).apply(
      fontFamily: 'OpenSans',
    ),
    accentTextTheme: TextTheme(
      display4: TextStyle(
        color: Color( 0xb3ffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      display3: TextStyle(
        color: Color( 0xb3ffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      display2: TextStyle(
        color: Color( 0xb3ffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      display1: TextStyle(
        color: Color( 0xb3ffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headline: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      title: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      subhead: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      body2: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      body1: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      caption: TextStyle(
        color: Color( 0xb3ffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      button: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      subtitle: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      overline: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ).apply(
      fontFamily: 'OpenSans',
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Color( 0xff999999 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      helperStyle: TextStyle(
        color: Color( 0xdd000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      hintStyle: TextStyle(
        color: Color( 0x8a000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorStyle: TextStyle(
        color: Color( 0xdd000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorMaxLines: null,
      hasFloatingPlaceholder: true,
      isDense: false,
      contentPadding: EdgeInsets.only(top:24,bottom:16,left:12, right:12),
      isCollapsed : false,
      prefixStyle: TextStyle(
        color: Color( 0xdd000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      suffixStyle: TextStyle(
        color: Color( 0xdd000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      counterStyle: TextStyle(
        color: Color( 0xdd000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      filled: true,
      fillColor: Color( 0x0a000000 ),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          gapPadding: 4
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          gapPadding: 4
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          gapPadding: 4
      ),
      disabledBorder: InputBorder.none,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          gapPadding: 4
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          gapPadding: 4
      ),
    ),
    iconTheme: IconThemeData(
      color: Color( 0xdd000000 ),
      opacity: 1,
      size: 24,
    ),
    primaryIconTheme: IconThemeData(
      color: Color( 0xffffffff ),
      opacity: 1,
      size: 24,
    ),
    accentIconTheme: IconThemeData(
      color: Color( 0xffffffff ),
      opacity: 1,
      size: 24,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: null,
      inactiveTrackColor: null,
      disabledActiveTrackColor: null,
      disabledInactiveTrackColor: null,
      activeTickMarkColor: null,
      inactiveTickMarkColor: null,
      disabledActiveTickMarkColor: null,
      disabledInactiveTickMarkColor: null,
      thumbColor: null,
      disabledThumbColor: null,
      //thumbShape: null(),
      overlayColor: null,
      valueIndicatorColor: null,
      //valueIndicatorShape: null(),
      showValueIndicator: ShowValueIndicator.always,
      valueIndicatorTextStyle: TextStyle(
        color: Color( 0xffffffff ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Color( 0xffffffff ),
      unselectedLabelColor: Color( 0xb2ffffff ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Color( 0x1f000000 ),
      brightness: Brightness.light,
      deleteIconColor: Color( 0xde000000 ),
      disabledColor: Color( 0x0c000000 ),
      labelPadding: EdgeInsets.only(top:0,bottom:0,left:8, right:8),
      labelStyle: TextStyle(
        color: Color( 0xde000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      padding: EdgeInsets.only(top:4,bottom:4,left:4, right:4),
      secondaryLabelStyle: TextStyle(
        color: Color( 0x3d000000 ),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      secondarySelectedColor: Color( 0x3d2196f3 ),
      selectedColor: Color( 0x3d000000 ),
      shape: StadiumBorder( side: BorderSide(color: Color( 0xff000000 ), width: 0, style: BorderStyle.none, ) ),
    ),
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color( 0xff000000 ), width: 0, style: BorderStyle.none, ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        )
    ),
  );
}