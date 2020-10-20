import 'package:flucompy/view/screen/home/HomeScreen.dart';
import 'package:flucompy/view/screen/settings/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlucompyNavigator {
  static FlucompyNavigator _instance;

  static FlucompyNavigator getInstance() {
    if (_instance == null) _instance = FlucompyNavigator();
    return _instance;
  }

  void navigateToHome(BuildContext context, [bool clearStack = true, Function() onNavigateBack]) {
    _navigateToScreen(context, HomeScreen(), clearStack, onNavigateBack);
  }

  void navigateToSettings(BuildContext context, [bool clearStack = true, Function() onNavigateBack]) {
    _navigateToScreen(context, SettingsScreen(), clearStack, onNavigateBack);
  }

  void _navigateToScreen(BuildContext context, Widget screen, [bool clearStack = true, Function() onNavigateBack]) {
    var route = MaterialPageRoute(builder: (context) => screen);
    if (clearStack) {
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false).then((value) {
        if(onNavigateBack != null)onNavigateBack();
      });
    } else {
      Navigator.of(context).push(route).then((value) {
        if(onNavigateBack != null)onNavigateBack();
      });
    }
  }
}
