import 'package:flucompy/ui/view/settings_view.dart';
import 'package:flucompy/ui/view/state/settings_view_state.dart';
import 'package:flucompy/util/constant.dart';
import 'package:flucompy/util/settings_util.dart';
import 'package:hack2s_flutter_util/presenter/presenter.dart';

abstract class SettingsStatePresenter extends Presenter<SettingsView, SettingsViewState> {
  SettingsStatePresenter(SettingsView view, SettingsViewState viewState) : super(view, viewState);

  Future<void> onCompassSelection(int index);
}

class SettingsStatePresenterImpl extends SettingsStatePresenter {
  CompassDirection _currentSelection = CompassDirection.values.first;

  SettingsStatePresenterImpl(SettingsView view, SettingsViewState viewState) : super(view, viewState);

  @override
  Future<void> onViewInit() async {
    await super.onViewInit();
    await _onRefresh();
  }

  @override
  Future<void> onAppResume() async {
    await super.onAppResume();
    await _onRefresh();
  }

  Future<void> _onRefresh() async {
    await FlucompySettingsUtil.loadCompassDirection().then((CompassDirection value) async {
      _currentSelection = value;
      await viewState.onRefresh();
    });
  }

  @override
  Future<void> onCompassSelection(int index) async {
    await FlucompySettingsUtil.setSelection(CompassDirection.values[index]).then((CompassDirection value) async {
      await viewState.goBack();
    });
  }
}
