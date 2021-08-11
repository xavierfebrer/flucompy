import 'package:get_it/get_it.dart';

class Locator {
  static final getIt = GetIt.I;

  static Future<void> initializeDI() async {
    await _data();
    await _domain();
    await _view();
  }

  static Future<void> _data() async {}

  static Future<void> _domain() async {}

  static Future<void> _view() async {}
}
