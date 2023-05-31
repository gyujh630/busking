import 'package:flutter/foundation.dart';

class StationData extends ChangeNotifier {
  String departureStation = '';
  String arrivalStation = '';

  void updateDepartureStation(String station) {
    departureStation = station;
    notifyListeners();
  }

  void updateArrivalStation(String station) {
    arrivalStation = station;
    notifyListeners();
  }
}