import 'package:flutter/material.dart';

import 'package:Shrine/supplemental/cut_corners_border.dart';
import 'package:Shrine/colors.dart';
import 'package:Shrine/home.dart';
import 'package:Shrine/login.dart';


class ShrineApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      theme: _shrineTheme,
      home: Home(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
    );
  }
   Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}


ThemeData _shrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kShrineBrown900,
    primaryColor: kShrinePink100,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kShrinePink100,
      colorScheme: base.colorScheme.copyWith(
        secondary: kShrineBrown900,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
    ),
    primaryIconTheme: base.iconTheme.copyWith(
        color: kShrineBrown900
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme : _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme :_buildShrineTextTheme(base.accentTextTheme),
  );
}


TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.copyWith (
    headline: base.headline.copyWith(fontWeight : FontWeight.w500,),
    title : base.title.copyWith(fontSize : 18.0),
    caption: base.caption.copyWith(fontSize : 14.0 ,fontWeight : FontWeight.w400 ,),
    body2: base.body2.copyWith(fontWeight : FontWeight.w500, fontSize : 16.0 ,),
  ).apply(
    fontFamily : 'Rubik',
    displayColor: kShrineBrown900,
    bodyColor: kShrineBrown900,
  );
}