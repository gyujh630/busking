import 'package:flutter/foundation.dart';

//하단바 선택 시 화면 전환을 위한 provider

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIdx = 0; //초기값

  get currentIdx => _currentIdx;

  set currentIdx(idx) {
    _currentIdx = idx;
    notifyListeners();
  }
}