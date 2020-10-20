import 'package:flucompy/util/Constant.dart';
import 'package:flucompy/util/Util.dart';
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
        Constant.TEXT_SETTINGS,
        style: TextStyle(
          color: Constant.COLOR_TEXT_LIGHT,
          fontWeight: Constant.TEXT_FONT_WEIGHT,
          letterSpacing: Constant.TEXT_LETTER_SPACING,
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
        padding: EdgeInsets.all(Constant.PADDING_SETTINGS_BORDER),
        child: Center(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Constant.COLOR_ACCENT,
            ),
            itemCount: CompassDirection.values.length,
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.all(Constant.PADDING_COMPASS_DIRECTION_TILE),
              title: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: Constant.TEXT_FONT_SIZE_BIG,
                    fontWeight: Constant.TEXT_FONT_WEIGHT_BOLD,
                    letterSpacing: Constant.TEXT_LETTER_SPACING,
                  ),
                  children: List.generate(Constant.TEXTS_COMPASS_DIRECTION[index].length, (subIndex) {
                    String text = Constant.TEXTS_COMPASS_DIRECTION[index][subIndex];
                    Color color = Constant.COLORS_COMPASS_DIRECTION[index][subIndex];
                    return TextSpan(
                        text: text,
                        style: TextStyle(
                          color: color,
                        ));
                  }),
                ),
              ),
              leading: Image.asset(Constant.ASSETS_IMAGE_COMPASS_DIRECTION_LIST[index]),
              onTap: () {
                Util.setSelection(CompassDirection.values[index]).then((value) {
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
