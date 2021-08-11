import 'package:flucompy/presenter/settings_state_presenter.dart';
import 'package:flucompy/ui/view/settings_view.dart';
import 'package:flucompy/ui/view/state/settings_view_state.dart';
import 'package:flucompy/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hack2s_flutter_util/util/app_data_provider.dart';
import 'package:hack2s_flutter_util/util/app_util.dart';
import 'package:hack2s_flutter_util/view/screen/base_screen.dart';
import 'package:hack2s_flutter_util/view/util/view_util.dart';

class SettingsScreen extends BaseScreen<SettingsView, SettingsViewState> implements SettingsView {
  @override
  SettingsScreenState createState() => SettingsScreenState(this);
}

class SettingsScreenState extends BaseScreenState<SettingsView, SettingsViewState, SettingsStatePresenter, SettingsScreen>
    implements SettingsViewState {
  SettingsScreenState(SettingsScreen screen) {
    presenter = SettingsStatePresenterImpl(screen, this);
  }

  @override
  Widget build(BuildContext context) {
    return Hack2sViewUtil.getBaseState(context,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: Hack2sViewUtil.getAppBar(
          context,
          title: FlucompyConstant.TEXT_SETTINGS,
          showBottom: true,
          centerTitle: false,
        ),
        body: getSettingsBody());
  }

  AppBar getSettingsAppBar() {
    return AppBar(
      title: Text(
        FlucompyConstant.TEXT_SETTINGS,
        style: TextStyle(
          color: FlucompyConstant.COLOR_TEXT(true),
          fontWeight: FlucompyConstant.TEXT_FONT_WEIGHT_LIGHT,
          letterSpacing: FlucompyConstant.TEXT_LETTER_SPACING,
        ),
      ),
      iconTheme: IconThemeData(color: FlucompyConstant.COLOR_TEXT(true)),
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }

  Widget getSettingsBody() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(FlucompyConstant.PADDING_SETTINGS_BORDER),
        child: Center(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            itemCount: CompassDirection.values.length,
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.all(FlucompyConstant.PADDING_COMPASS_DIRECTION_TILE),
              title: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: FlucompyConstant.TEXT_FONT_SIZE_BIG,
                    fontWeight: FlucompyConstant.TEXT_FONT_WEIGHT_LIGHT,
                    letterSpacing: FlucompyConstant.TEXT_LETTER_SPACING,
                  ),
                  children: List.generate(FlucompyConstant.TEXTS_COMPASS_DIRECTION[index].length, (subIndex) {
                    String text = FlucompyConstant.TEXTS_COMPASS_DIRECTION[index][subIndex];
                    Color color = FlucompyConstant.COLORS_COMPASS_DIRECTION[index][subIndex];
                    return TextSpan(
                      text: text,
                      style: Hack2sViewUtil.getDefaultPrimaryTextStyle(
                        context,
                        fontSize: FlucompyConstant.TEXT_FONT_SIZE_BIG,
                        color: !Hack2sAppUtil.isDarkMode(context) ? color : null,
                        fontWeight: Hack2sAppDataProvider.appDataProvider.TEXT_FONT_WEIGHT_LIGHT,
                        letterSpacing: Hack2sAppDataProvider.appDataProvider.TEXT_LETTER_SPACING,
                      ),
                    );
                  }),
                ),
              ),
              leading: Image.asset(FlucompyConstant.ASSETS_IMAGE_COMPASS_DIRECTION_LIST[index]),
              onTap: () async => await presenter.onCompassSelection(index),
              isThreeLine: false,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> onRefresh() async {
    setState(() {});
  }

  @override
  Future<void> goBack() async => Navigator.pop(context);
}
