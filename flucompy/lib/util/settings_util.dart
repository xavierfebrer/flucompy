import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class FlucompySettingsUtil {

  static Future<CompassDirection> setSelection(CompassDirection item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(FlucompyConstant.PREFS_COMPASS_DIRECTION_SELECTION, item.index);
    return CompassDirection.values[prefs.getInt(FlucompyConstant.PREFS_COMPASS_DIRECTION_SELECTION) ?? CompassDirection.RED.index];
  }

  static Future<CompassDirection> loadCompassDirection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return CompassDirection.values[prefs.getInt(FlucompyConstant.PREFS_COMPASS_DIRECTION_SELECTION) ?? CompassDirection.RED.index];
  }
}