import 'dart:ui';

import 'package:flutter/material.dart';

class FlucompyConstant {
  static const String APP_NAME = "Flucompy";
  static const Color COLOR_PRIMARY = Color(0xFF14B951);
  static const Color COLOR_ACCENT = Color(0xFF795548);
  static const Color COLOR_TEXT_LIGHT = Color(0xFFF2F2F2);
  static const Color COLOR_TEXT_LIGHT_2 = Color(0xFFD1D1D1);
  static const Color COLOR_TEXT_DARK = Color(0xFF212121);
  static const Color COLOR_TEXT_DARK_2 = Color(0xFF535353);
  static const double PADDING_HOME_BORDER = 7.0;
  static const double PADDING_SETTINGS_BORDER = 0.0;
  static const double PADDING_COMPASS_DIRECTION_TILE = 16.0;
  static const double PADDING_BUTTON_CHECK_PERMISSIONS = 32.0;
  static const double ELEVATION_BUTTON_CHECK_PERMISSIONS = 16.0;

  static String TEXT_TITLE_LOCATION_PERMISSION_REQUIRED = "Location Permission Required";
  static String TEXT_MESSAGE_LOCATION_PERMISSION_REQUIRED = "Enable the location permissions to enable the compass functionality.";
  static String TEXT_OPEN_APP_SETTINGS = "Open App Settings";
  static String TEXT_REQUEST_PERMISSIONS = "Request Permissions";
  static String TEXT_SENSOR_NOT_SUPPORTED = "Sensor not supported.";
  static String TEXT_CHECK_PERMISSIONS = "Check Permissions";
  static String TEXT_SETTINGS = "Settings";

  static double TEXT_FONT_SIZE_BIG = 26;
  static FontWeight TEXT_FONT_WEIGHT = FontWeight.w300;
  static FontWeight TEXT_FONT_WEIGHT_BOLD = FontWeight.w400;
  static double TEXT_LETTER_SPACING = -0.0;

  static String TEXT_ERROR_READING_SENSOR(Object? error) => "Error reading sensor: $error";

  static String TEXT_COMPASS_INFO(double lastDirection) => "${lastDirection.toStringAsFixed(2)}º";

  static List<List<String>> TEXTS_COMPASS_DIRECTION = [
    ["Red"],
    ["Red ", "Blue"],
    ["Green"],
    ["Green ", "Blue"],
    ["Orange"],
    ["Orange ", "Blue"],
    ["Pink"],
    ["Pink ", "Blue"],
    ["Black"],
    ["Black ", "Blue"]
  ];
  static List<List<Color>> COLORS_COMPASS_DIRECTION = [
    [Color(0xFFb84300)],
    [Color(0xFFb84300), Color(0xFF0051AB)],
    [Color(0xFF007500)],
    [Color(0xFF007500), Color(0xFF0051AB)],
    [Color(0xFF9b7600)],
    [Color(0xFF9b7600), Color(0xFF0051AB)],
    [Color(0xFFb844b8)],
    [Color(0xFFb844b8), Color(0xFF0051AB)],
    [Color(0xFF141414)],
    [Color(0xFF141414), Color(0xFF0051AB)]
  ];

  static List<String> ASSETS_IMAGE_COMPASS_DIRECTION_LIST = [
    "assets/compass_direction_1.png",
    "assets/compass_direction_2.png",
    "assets/compass_direction_3.png",
    "assets/compass_direction_4.png",
    "assets/compass_direction_5.png",
    "assets/compass_direction_6.png",
    "assets/compass_direction_7.png",
    "assets/compass_direction_8.png",
    "assets/compass_direction_9.png",
    "assets/compass_direction_10.png",
  ];

  static String PREFS_COMPASS_DIRECTION_SELECTION = "PREFS_COMPASS_DIRECTION_SELECTION";
}

enum CompassDirection { RED, RED_BLUE, GREEN, GREEN_BLUE, ORANGE, ORANGE_BLUE, PINK, PINK_BLUE, BLACK, BLACK_BLUE }
