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
  SettingsScreenState(SettingsScreen screen) : super(screen) {
    presenter = SettingsStatePresenterImpl(screen, this);
  }

  @override
  Widget build(BuildContext context) {
    return Hack2sViewUtil.getBaseState(context,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: Hack2sViewUtil.getAppBar(
          context,
          title: FlucompyConstant.TEXT_SETTINGS,
          centerTitle: false,
        ),
        body: getBody());
  }

  Widget getBody() {
    return SafeArea(
      child: ListView.separated(
        separatorBuilder: (context, index) => Hack2sViewUtil.getDefaultListDivider(context),
        itemCount: CompassDirection.values.length,
        itemBuilder: (context, index) => ListTile(
          contentPadding: EdgeInsets.all(FlucompyConstant.PADDING_COMPASS_DIRECTION_TILE),
          title: RichText(
            text: TextSpan(
              style: Hack2sViewUtil.getDefaultPrimaryTextStyle(
                context,
                fontSize: FlucompyConstant.TEXT_FONT_SIZE_BIG,
                fontWeight: Hack2sAppDataProvider.appDataProvider.TEXT_FONT_WEIGHT_LIGHT,
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
    );
  }

  @override
  Future<void> onRefresh() async {
    setState(() {});
  }

  @override
  Future<void> goBack() async => Navigator.pop(context);
}
