import 'package:flucompy/ui/view/home_view.dart';
import 'package:flucompy/ui/view/state/home_view_state.dart';
import 'package:hack2s_flutter_util/presenter/presenter.dart';

abstract class HomeStatePresenter extends Presenter<HomeView, HomeViewState> {
  HomeStatePresenter(HomeView view, HomeViewState viewState) : super(view, viewState);

  Future<void> onSettingsSelected();
}

class HomeStatePresenterImpl extends HomeStatePresenter {
  HomeStatePresenterImpl(HomeView view, HomeViewState viewState) : super(view, viewState);

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

  Future<void> _onRefresh() async => await viewState.onRefresh();

  @override
  Future<void> onSettingsSelected() async => await viewState.goToSettings();
}
