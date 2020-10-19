import 'package:flucompy/view/screen/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlucompyNavigator {
  static FlucompyNavigator _instance;

  static FlucompyNavigator getInstance() {
    if (_instance == null) _instance = FlucompyNavigator();
    return _instance;
  }

  void navigateToHome(BuildContext context, [bool clearStack = true]) {
    _navigateToScreen(context, HomeScreen(), clearStack);
  }

  void _navigateToScreen(BuildContext context, Widget screen, [bool clearStack = true]) {
    var route = MaterialPageRoute(builder: (context) => screen);
    if (clearStack) {
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
    } else {
      Navigator.of(context).push(route);
    }
  }
}
