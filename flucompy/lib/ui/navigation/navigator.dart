import 'package:flucompy/ui/screen/home/home_screen.dart';
import 'package:flucompy/ui/screen/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hack2s_flutter_util/view/navigation/navigator.dart';

class FlucompyNavigator {
  static void navigateToHome(BuildContext context, [bool clearStack = true, Function()? onNavigateBack]) {
    Hack2sNavigator.navigateToScreen(context, HomeScreen(), clearStack, onNavigateBack);
  }

  static void navigateToSettings(BuildContext context, [bool clearStack = true, Function()? onNavigateBack]) {
    Hack2sNavigator.navigateToScreen(context, SettingsScreen(), clearStack, onNavigateBack);
  }
}
