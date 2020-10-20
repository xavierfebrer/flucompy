import 'dart:math' as math;

import 'package:flucompy/util/Constant.dart';
import 'package:flucompy/util/PermissionHelper.dart';
import 'package:flucompy/util/Util.dart';
import 'package:flucompy/view/navigation/FlucompyNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _hasPermissions = false;
  double _lastDirection = 0.0;
  CompassDirection _currentSelection = CompassDirection.DEFAULT;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: getHomeAppBar(),
      body: getHomeBody(),
    );
  }

  Widget getHomeAppBar() {
    return AppBar(
      title: Text(
        Constant.APP_NAME,
        style: TextStyle(
          color: Constant.COLOR_TEXT_LIGHT,
        ),
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).accentColor,
      iconTheme: IconThemeData(color: Constant.COLOR_TEXT_LIGHT),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
          ),
          onPressed: () {
            onInputShare();
          },
        ),
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

  Widget getHomeBody() {
    return SafeArea(
        child: Container(
            padding: EdgeInsets.all(Constant.PADDING_HOME_BORDER),
            child: Center(
              child: getCompassWidget(),
            )));
  }

  Future<void> showLocationPermissionPopup() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Constant.TEXT_TITLE_LOCATION_PERMISSION_REQUIRED),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Constant.TEXT_MESSAGE_LOCATION_PERMISSION_REQUIRED),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Constant.TEXT_REQUEST_PERMISSIONS),
              onPressed: () {
                PermissionHelper.requestPermissions([PermissionGroup.locationWhenInUse], (permissionsResult) {
                  Navigator.of(context).pop();
                  checkLocationPermission();
                });
              },
            ),
            FlatButton(
              child: Text(Constant.TEXT_OPEN_APP_SETTINGS),
              onPressed: () {
                Navigator.of(context).pop();
                PermissionHelper.openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  void onInputShare() => Share.share(getCompassInfo());

  void onOpenSettings() => FlucompyNavigator.getInstance().navigateToSettings(context, false, (){
    onRefresh();
  });

  String getCompassInfo() => Constant.TEXT_COMPASS_INFO(_lastDirection);

  void checkLocationPermission() {
    PermissionHelper.checkPermissionStatus(PermissionGroup.locationWhenInUse, (permissionStatus) {
      setState(() {
        _hasPermissions = permissionStatus == PermissionStatus.granted;
      });
    });
  }

  Widget getCompassWidget() {
    var compassWidget = StreamBuilder<double>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(Constant.TEXT_ERROR_READING_SENSOR(snapshot.error));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        double direction = snapshot.data;
        _lastDirection = direction ?? 0;
        if (direction == null) {
          return Center(
            child: Text(Constant.TEXT_SENSOR_NOT_SUPPORTED),
          );
        }
        return Container(
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: ((direction ?? 0) * (math.pi / 180) * -1),
            child: Image.asset(
              Constant.ASSETS_IMAGE_COMPASS_DIRECTION_LIST[_currentSelection.index],
            ),
          ),
        );
      },
    );
    if (!_hasPermissions) {
      return FlatButton(
        onPressed: () {
          showLocationPermissionPopup();
        },
        child: Text(
          Constant.TEXT_CHECK_PERMISSIONS,
          style: TextStyle(
            color: Constant.COLOR_TEXT_LIGHT,
          ),
        ),
        color: Theme.of(context).accentColor,
      );
    } else {
      return compassWidget;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onRefresh();
    }
  }

  void onRefresh() {
    Util.loadCompassDirection().then((value) {
      _currentSelection = value;
      checkLocationPermission();
    });
  }
}
