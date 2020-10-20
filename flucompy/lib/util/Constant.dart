import 'dart:ui';

import 'package:flutter/material.dart';

class Constant {
  static const String EMPTY_STRING = "";
  static const String APP_NAME = "Flucompy";
  static const Color COLOR_PRIMARY = Color(0xFF00BCD4);
  static const Color COLOR_ACCENT = Color(0xFF795548);
  static const Color COLOR_TEXT_LIGHT = Color(0xFFF2F2F2);
  static const Color COLOR_TEXT_DARK = Color(0xFF212121);
  static const double PADDING_HOME_BORDER = 7.0;

  static String TEXT_TITLE_LOCATION_PERMISSION_REQUIRED = "Location Permission Required";
  static String TEXT_MESSAGE_LOCATION_PERMISSION_REQUIRED = "Enable the location permissions to enable the compass functionality.";
  static String TEXT_OPEN_APP_SETTINGS = "Open App Settings";
  static String TEXT_REQUEST_PERMISSIONS = "Request Permissions";
  static String TEXT_SENSOR_NOT_SUPPORTED = "Sensor not supported.";
  static String TEXT_CHECK_PERMISSIONS = "Check Permissions";

  static String TEXT_ERROR_READING_SENSOR(String error) => "Error reading sensor: $error";

  static String TEXT_COMPASS_INFO(double lastDirection) => "${lastDirection.toStringAsFixed(2)}º";

  static String ASSETS_IMAGE_COMPASS_DIRECTION = "assets/compass_direction.png";
}
