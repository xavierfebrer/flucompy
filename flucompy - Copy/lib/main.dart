import 'package:flucompy/ui/screen/home/home_screen.dart';
import 'package:flucompy/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hack2s_flutter_util/util/app_data_provider.dart';
import 'package:hack2s_flutter_util/util/app_util.dart';
import 'package:hack2s_flutter_util/view/app/base_app.dart';

import 'di/locator.dart';

Future<void> main() async {
  await Hack2sAppUtil.runApplication([DeviceOrientation.portraitUp], FlucompyAppDataProvider(), () async {
    return await Future(() async {
      await Locator.initializeDI();
      return FlucompyApp();
    });
  });
}

class FlucompyApp extends BaseApp {
  FlucompyApp({Key? key}) : super(key: key);

  @override
  Widget getWidget() => Hack2sAppUtil.getDefaultMaterialApp(HomeScreen());
}

class FlucompyAppDataProvider extends Hack2sAppDataProvider {
  @override
  String get APP_NAME => FlucompyConstant.APP_NAME;

  @override
  Color get COLOR_PRIMARY => FlucompyConstant.COLOR_PRIMARY;

  @override
  Color get COLOR_SECONDARY => FlucompyConstant.COLOR_SECONDARY;

  @override
  Color COLOR_TEXT([bool darkMode = false]) => FlucompyConstant.COLOR_TEXT(darkMode);

  @override
  Color COLOR_TEXT_2([bool darkMode = false]) => FlucompyConstant.COLOR_TEXT_2(darkMode);

  @override
  FontWeight get TEXT_FONT_WEIGHT_LIGHT => FlucompyConstant.TEXT_FONT_WEIGHT_LIGHT;

  @override
  FontWeight get TEXT_FONT_WEIGHT => FlucompyConstant.TEXT_FONT_WEIGHT;

  @override
  FontWeight get TEXT_FONT_WEIGHT_MEDIUM => FlucompyConstant.TEXT_FONT_WEIGHT_MEDIUM;

  @override
  FontWeight get TEXT_FONT_WEIGHT_SEMI_BOLD => FlucompyConstant.TEXT_FONT_WEIGHT_SEMI_BOLD;

  @override
  FontWeight get TEXT_FONT_WEIGHT_BOLD => FlucompyConstant.TEXT_FONT_WEIGHT_BOLD;

  @override
  double get TEXT_LETTER_SPACING => FlucompyConstant.TEXT_LETTER_SPACING;

  @override
  double get TEXT_PRIMARY_FONT_SIZE => FlucompyConstant.TEXT_PRIMARY_FONT_SIZE;

  @override
  double get TEXT_SECONDARY_FONT_SIZE => FlucompyConstant.TEXT_SECONDARY_FONT_SIZE;
}
