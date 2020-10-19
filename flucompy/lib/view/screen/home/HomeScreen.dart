import 'dart:math' as math;

import 'package:flucompy/util/Constant.dart';
import 'package:flucompy/util/PermissionHelper.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLocationPermission();
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
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
            color: Constant.COLOR_TEXT_LIGHT,
          ),
          onPressed: () {
            onInputShare();
          },
        ),
        /*IconButton(
          icon: Icon(
            Icons.settings,
            color: Constant.COLOR_TEXT_LIGHT,
          ),
          onPressed: () {
            onOpenSettings();
          },
        ),*/
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
          title: Text('Location Permission Required'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enable the location permissions to enable the compass functionality.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Request Permissions'),
              onPressed: () {
                PermissionHelper.requestPermissions([PermissionGroup.locationWhenInUse], (permissionsResult) {
                  Navigator.of(context).pop();
                  checkLocationPermission();
                });
              },
            ),
            FlatButton(
              child: Text('Open App Settings'),
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

  void onOpenSettings() {
    // TODO
  }

  String getCompassInfo() => "${_lastDirection.toStringAsFixed(2)}º";

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
          return Text('Error reading sensor: ${snapshot.error}');
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
            child: Text("Sensor not supported."),
          );
        }
        return Container(
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: ((direction ?? 0) * (math.pi / 180) * -1),
            child: Image.asset(
              'assets/compass_direction.png',
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
          "Check Permissions",
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
      checkLocationPermission();
    }
  }
}
