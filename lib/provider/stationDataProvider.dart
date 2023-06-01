import 'package:flutter/foundation.dart';
import 'package:busking/Screen/homeScreen/selectionStationPage/selectionStationPage.dart';
class StationData extends ChangeNotifier {
  String departureStation = ''; // 출발 정류장 변수
  String arrivalStation = ''; // 도착 정류장 변수

  // ->   final StationData stationData; 로 사용하면 되는 듯

  void updateDepartureStation(String station) {
    departureStation = station;
    notifyListeners();
  }

  void updateArrivalStation(String station) {
    arrivalStation = station;
    notifyListeners();
  }
}