import 'package:flucompy/ui/view/settings_view.dart';
import 'package:hack2s_flutter_util/view/view/state/view_state.dart';

abstract class SettingsViewState extends ViewState<SettingsView> {
  Future<void> onRefresh();

  Future<void> goBack();
}
