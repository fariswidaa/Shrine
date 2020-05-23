import 'package:Shrine/backdrop.dart';
import 'package:Shrine/category_menu_page.dart';
import 'package:Shrine/model/product.dart';
import 'package:flutter/material.dart';

import 'package:Shrine/supplemental/cut_corners_border.dart';
import 'package:Shrine/colors.dart';
import 'package:Shrine/home.dart';
import 'package:Shrine/login.dart';


class ShrineApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ShrineAppState createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  Category _currentCategory = Category.all;

  void _onCategoryTap (Category category){
    setState(() {
     _currentCategory = category ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      theme: _shrineTheme,
      home: Backdrop(
        category: Category.all,
        frontLayer: Home(category: _currentCategory,),
        backLayer: CategoryMenuPage(currentCategory: _currentCategory, onCategoryTap: _onCategoryTap),
        frontTitle: Text('SHRINE',),
        backTitle: Text('Menu',),
      ),
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
      fullscreenDialog: false,
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
    headline5: base.headline5.copyWith(fontWeight : FontWeight.w500,),
    headline6 : base.headline6.copyWith(fontSize : 18.0),
    caption: base.caption.copyWith(fontSize : 14.0 ,fontWeight : FontWeight.w400 ,),
    bodyText1: base.bodyText1.copyWith(fontWeight : FontWeight.w500, fontSize : 16.0 ,),
  ).apply(
    fontFamily : 'Rubik',
    displayColor: kShrineBrown900,
    bodyColor: kShrineBrown900,
  );
}