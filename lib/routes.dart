import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/LoginPage/Login.dart';

import 'Screens/HomePage/Home.dart';
import 'Screens/IntroductionScreen/IntroductionPage.dart';
import 'Screens/ThemesPage/`Themes.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "//": (BuildContext context) => LoginPage(),
  "Themes": (BuildContext context) => ThemesPage(),
  "TheIntroductionScreen": (BuildContext context) => IntroductionScreenPage(),
  "MyHomePage": (BuildContext context) => MyHomePage(),
};
