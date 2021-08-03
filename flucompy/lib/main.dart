import 'package:flucompy/util/constant.dart';
import 'package:flucompy/util/settings_util.dart';
import 'package:flucompy/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hack2s_flutter_util/util/app_util.dart';
import 'package:hack2s_flutter_util/view/app/base_app.dart';

void main() {
  Hack2sAppUtil.runApplication([DeviceOrientation.portraitUp], () => FlucompyApp());
}

class FlucompyApp extends BaseApp {
  FlucompyApp({Key? key}) : super(key: key);

  @override
  Widget getWidget() => Hack2sAppUtil.getDefaultMaterialApp(
      FlucompyConstant.APP_NAME, Hack2sAppUtil.getDefaultThemeData(FlucompyConstant.COLOR_PRIMARY, FlucompyConstant.COLOR_ACCENT), HomeScreen());
}
