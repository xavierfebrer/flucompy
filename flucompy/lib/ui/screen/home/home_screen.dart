import 'dart:math' as math;

import 'package:flucompy/presenter/home_state_presenter.dart';
import 'package:flucompy/ui/navigation/navigator.dart';
import 'package:flucompy/ui/view/home_view.dart';
import 'package:flucompy/ui/view/state/home_view_state.dart';
import 'package:flucompy/util/constant.dart';
import 'package:flucompy/util/settings_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:hack2s_flutter_util/util/app_data_provider.dart';
import 'package:hack2s_flutter_util/util/permission_helper.dart';
import 'package:hack2s_flutter_util/util/popup_util.dart';
import 'package:hack2s_flutter_util/view/screen/base_screen.dart';
import 'package:hack2s_flutter_util/view/util/view_util.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends BaseScreen<HomeView, HomeViewState> implements HomeView {
  @override
  HomeScreenState createState() => HomeScreenState(this);
}

class HomeScreenState extends BaseScreenState<HomeView, HomeViewState, HomeStatePresenter, HomeScreen> implements HomeViewState {
  bool _hasPermissions = false;
  double _lastDirection = 0.0;
  CompassDirection _currentSelection = CompassDirection.RED;

  HomeScreenState(HomeScreen screen) {
    presenter = HomeStatePresenterImpl(screen, this);
  }

  @override
  Widget build(BuildContext context) {
    return Hack2sViewUtil.getBaseState(context,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: Hack2sViewUtil.getAppBar(
          context,
          title: Hack2sAppDataProvider.appDataProvider.APP_NAME,
          titleTextStyle: Hack2sViewUtil.getDefaultPrimaryTextStyle(
            context,
            fontSize: FlucompyConstant.TEXT_FONT_SIZE_BIG,
            color: Hack2sAppDataProvider.appDataProvider.COLOR_TEXT(true),
            fontWeight: Hack2sAppDataProvider.appDataProvider.TEXT_FONT_WEIGHT_LIGHT,
          ),
          showBottom: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
              ),
              onPressed: () async => await onOpenSettings(),
            ),
          ],
          centerTitle: true,
        ),
        body: getBody());
  }

  Future<void> onOpenSettings() async => await presenter.onSettingsSelected();

  Widget getBody() {
    return SafeArea(
      child: getBodyContent(),
    );
  }

  Widget getBodyContent() {
    var compassWidget = Center(
        child: StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(FlucompyConstant.TEXT_ERROR_READING_SENSOR(snapshot.error),
              style: Hack2sViewUtil.getDefaultPrimaryTextStyle(context));
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
            child: Text(FlucompyConstant.TEXT_SENSOR_NOT_SUPPORTED, style: Hack2sViewUtil.getDefaultPrimaryTextStyle(context)),
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
    ));
    if (!_hasPermissions) {
      return Center(
        child: RaisedButton(
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
              color: Hack2sAppDataProvider.appDataProvider.COLOR_TEXT(true),
              fontWeight: Hack2sAppDataProvider.appDataProvider.TEXT_FONT_WEIGHT_LIGHT,
            ),
          ),
          color: Theme.of(context).colorScheme.secondary,
        ),
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
  Future<void> onRefresh() async {
    await FlucompySettingsUtil.loadCompassDirection().then((value) async {
      _currentSelection = value;
      await checkLocationPermission();
    });
  }

  @override
  Future<void> goToSettings() async => FlucompyNavigator.navigateToSettings(context, false, () async => await presenter.onAppResume());
}
