import 'package:flucompy/util/Constant.dart';
import 'package:flucompy/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  CompassDirection _currentSelection = CompassDirection.DEFAULT;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Util.loadCompassDirection().then((value) {
        setState(() {
          _currentSelection = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: getSettingsAppBar(),
      body: getSettingsBody(),
    );
  }

  Widget getSettingsAppBar() {
    return AppBar(
      title: Text(
        Constant.TEXT_SETTINGS_TITLE,
        style: TextStyle(
          color: Constant.COLOR_TEXT_LIGHT,
        ),
      ),
      iconTheme: IconThemeData(color: Constant.COLOR_TEXT_LIGHT),
      centerTitle: false,
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  Widget getSettingsBody() {
    return SafeArea(
        child: Container(
            padding: EdgeInsets.all(Constant.PADDING_HOME_BORDER),
            child: Center(
              child: ListView(
                children: CompassDirection.values.map((item) {
                  return RadioListTile<CompassDirection>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    secondary: Image.asset(
                      Constant.ASSETS_IMAGE_COMPASS_DIRECTION_LIST[item.index],
                    ),
                    title: Text(item.toString()),
                    value: item,
                    groupValue: _currentSelection,
                    onChanged: (CompassDirection value) {
                      setSelection(value);
                    },
                  );
                }).toList(),
              ),
            )));
  }

  setSelection(CompassDirection item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Constant.PREFS_COMPASS_DIRECTION_SELECTION, item.index);
    _currentSelection = CompassDirection.values[prefs.getInt(Constant.PREFS_COMPASS_DIRECTION_SELECTION) ?? CompassDirection.DEFAULT.index];
    Navigator.pop(context);
  }

  loadSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentSelection = CompassDirection.values[prefs.getInt(Constant.PREFS_COMPASS_DIRECTION_SELECTION) ?? CompassDirection.DEFAULT.index];
    setState(() {});
  }
}
