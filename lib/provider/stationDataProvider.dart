import 'package:flutter/foundation.dart';


// 정류장 선택 페이지에서 출발 정류장, 도착 정류장 변수값 업데이트를 위한 provider


class StationData extends ChangeNotifier {
  String departureStation = ''; // 출발 정류장 변수
  String arrivalStation = ''; // 도착 정류장 변수

  void updateDepartureStation(String station) {
    departureStation = station;
    notifyListeners();
  }

  void updateArrivalStation(String station) {
    arrivalStation = station;
    notifyListeners();
  }

  void resetStations() {
    departureStation = '';
    arrivalStation = '';
    notifyListeners();
  }
}