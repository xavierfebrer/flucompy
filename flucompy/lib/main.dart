import 'package:flucompy/util/Constant.dart';
import 'package:flucompy/util/Util.dart';
import 'package:flucompy/view/screen/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(FluCompyApp());
  });
}

class FluCompyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constant.APP_NAME,
      theme: ThemeData(
        primarySwatch: Util.createMaterialColor(Constant.COLOR_PRIMARY),
        accentColor: Constant.COLOR_ACCENT,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
