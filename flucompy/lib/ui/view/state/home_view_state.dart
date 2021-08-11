import 'package:flucompy/ui/view/home_view.dart';
import 'package:hack2s_flutter_util/view/view/state/view_state.dart';

abstract class HomeViewState extends ViewState<HomeView> {
  Future<void> onRefresh();

  Future<void> goToSettings();
}
