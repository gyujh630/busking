import 'package:flutter/foundation.dart';

class BusSetProvider extends ChangeNotifier {
  bool _isBusSet = false;

  bool get isBusSet => _isBusSet;

  set isBusSet(bool value) {
    _isBusSet = value;
    notifyListeners();
  }
}