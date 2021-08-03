import 'package:flucompy/util/constant.dart';
import 'package:flucompy/util/settings_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  CompassDirection _currentSelection = CompassDirection.RED;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      FlucompySettingsUtil.loadCompassDirection().then((value) {
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

  AppBar getSettingsAppBar() {
    return AppBar(
      title: Text(
        FlucompyConstant.TEXT_SETTINGS,
        style: TextStyle(
          color: FlucompyConstant.COLOR_TEXT_LIGHT,
          fontWeight: FlucompyConstant.TEXT_FONT_WEIGHT,
          letterSpacing: FlucompyConstant.TEXT_LETTER_SPACING,
        ),
      ),
      iconTheme: IconThemeData(color: FlucompyConstant.COLOR_TEXT_LIGHT),
      centerTitle: false,
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  Widget getSettingsBody() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(FlucompyConstant.PADDING_SETTINGS_BORDER),
        child: Center(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: FlucompyConstant.COLOR_ACCENT,
            ),
            itemCount: CompassDirection.values.length,
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.all(FlucompyConstant.PADDING_COMPASS_DIRECTION_TILE),
              title: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: FlucompyConstant.TEXT_FONT_SIZE_BIG,
                    fontWeight: FlucompyConstant.TEXT_FONT_WEIGHT_BOLD,
                    letterSpacing: FlucompyConstant.TEXT_LETTER_SPACING,
                  ),
                  children: List.generate(FlucompyConstant.TEXTS_COMPASS_DIRECTION[index].length, (subIndex) {
                    String text = FlucompyConstant.TEXTS_COMPASS_DIRECTION[index][subIndex];
                    Color color = FlucompyConstant.COLORS_COMPASS_DIRECTION[index][subIndex];
                    return TextSpan(
                        text: text,
                        style: TextStyle(
                          color: color,
                        ));
                  }),
                ),
              ),
              leading: Image.asset(FlucompyConstant.ASSETS_IMAGE_COMPASS_DIRECTION_LIST[index]),
              onTap: () {
                FlucompySettingsUtil.setSelection(CompassDirection.values[index]).then((value) {
                  _currentSelection = value;
                  Navigator.pop(context);
                });
              },
              isThreeLine: false,
            ),
          ),
        ),
      ),
    );
  }
}
