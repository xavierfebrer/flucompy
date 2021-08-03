import 'dart:math' as math;

import 'package:flucompy/util/constant.dart';
import 'package:flucompy/util/settings_util.dart';
import 'package:flucompy/view/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:hack2s_flutter_util/util/permission_helper.dart';
import 'package:hack2s_flutter_util/util/popup_util.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool _hasPermissions = false;
  double _lastDirection = 0.0;
  CompassDirection _currentSelection = CompassDirection.RED;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: getHomeAppBar(),
      body: getHomeBody(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  AppBar getHomeAppBar() {
    return AppBar(
      title: Text(
        FlucompyConstant.APP_NAME,
        style: TextStyle(
          color: FlucompyConstant.COLOR_TEXT_LIGHT,
          fontWeight: FlucompyConstant.TEXT_FONT_WEIGHT,
          letterSpacing: FlucompyConstant.TEXT_LETTER_SPACING,
        ),
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      iconTheme: IconThemeData(color: FlucompyConstant.COLOR_TEXT_LIGHT),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.settings,
          ),
          onPressed: () {
            onOpenSettings();
          },
        ),
      ],
    );
  }

  void onOpenSettings() => FlucompyNavigator.navigateToSettings(context, false, () {
        onRefresh();
      });

  Widget getHomeBody() {
    return SafeArea(
        child: Container(
            padding: EdgeInsets.all(FlucompyConstant.PADDING_HOME_BORDER),
            child: Center(
              child: getCompassWidget(),
            )));
  }

  Widget getCompassWidget() {
    var compassWidget = StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(FlucompyConstant.TEXT_ERROR_READING_SENSOR(snapshot.error),
              style: TextStyle(
                color: FlucompyConstant.COLOR_TEXT_DARK,
                fontWeight: FlucompyConstant.TEXT_FONT_WEIGHT,
                letterSpacing: FlucompyConstant.TEXT_LETTER_SPACING,
              ));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        CompassEvent? compassEvent = snapshot.data;
        _lastDirection = compassEvent?.heading ?? 0;
        if (compassEvent == null) {
          return Center(
            child: Text(FlucompyConstant.TEXT_SENSOR_NOT_SUPPORTED,
                style: TextStyle(
                  color: FlucompyConstant.COLOR_TEXT_DARK,
                  fontWeight: FlucompyConstant.TEXT_FONT_WEIGHT,
                  letterSpacing: FlucompyConstant.TEXT_LETTER_SPACING,
                )),
          );
        }
        return Container(
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: ((compassEvent.heading ?? 0) * (math.pi / 180) * -1),
            child: Image.asset(
              FlucompyConstant.ASSETS_IMAGE_COMPASS_DIRECTION_LIST[_currentSelection.index],
            ),
          ),
        );
      },
    );
    if (!_hasPermissions) {
      return RaisedButton(
        padding: EdgeInsets.all(FlucompyConstant.PADDING_BUTTON_CHECK_PERMISSIONS),
        elevation: FlucompyConstant.ELEVATION_BUTTON_CHECK_PERMISSIONS,
        onPressed: () async {
          await Hack2sPopupUtil.showRequestPermissionsPopup(context, FlucompyConstant.TEXT_TITLE_LOCATION_PERMISSION_REQUIRED,
              FlucompyConstant.TEXT_MESSAGE_LOCATION_PERMISSION_REQUIRED, [Permission.locationWhenInUse], (_) async {
            await checkLocationPermission();
          });
        },
        child: Text(
          FlucompyConstant.TEXT_CHECK_PERMISSIONS,
          style: TextStyle(
            fontSize: FlucompyConstant.TEXT_FONT_SIZE_BIG,
            color: FlucompyConstant.COLOR_TEXT_LIGHT,
            fontWeight: FlucompyConstant.TEXT_FONT_WEIGHT_BOLD,
            letterSpacing: FlucompyConstant.TEXT_LETTER_SPACING,
          ),
        ),
        color: Theme.of(context).colorScheme.secondary,
      );
    } else {
      return compassWidget;
    }
  }

  Future<void> checkLocationPermission() async {
    PermissionStatus permissionStatus = await Hack2sPermissionHelper.checkPermissionStatus(Permission.locationWhenInUse);
    setState(() {
      _hasPermissions = permissionStatus == PermissionStatus.granted;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onRefresh();
    }
  }

  void onRefresh() {
    FlucompySettingsUtil.loadCompassDirection().then((value) {
      _currentSelection = value;
      checkLocationPermission();
    });
  }
}
