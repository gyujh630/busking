import 'dart:convert';
import 'package:busking/APIKey.dart';
import 'package:busking/APIUrl.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:busking/JsonDecode.dart';

class BusRoute{
  final String? routeID;

  BusRoute({
    required this.routeID
});

  factory BusRoute.fromJson(Map<String, dynamic> routeData) {
    return BusRoute(routeID: JsonDecode.findStringByKeyInMap('routeId', routeData));
  }

  static Future<List<String>> callBusList(String keyword) async {
    List<dynamic> busData = await _callBusData(keyword);
    final List<String> busList = [];

    if (busData == null || busData.isEmpty) {
      return busList; // 빈 리스트 반환
    }

    for (var bus in busData) {
      if (bus.containsKey("routeName")) {
        busList.add(bus["routeName"]);
      }
    }

    return busList;
  }

  static Future<List<String>> callRouteIdList(String keyword) async {
    List<dynamic> busData = await _callBusData(keyword);
    final List<String> routeIdList = [];

    if (busData == null || busData.isEmpty) {
      return routeIdList; // 빈 리스트 반환
    }

    for (var bus in busData) {
      if (bus.containsKey("routeId")) {
        routeIdList.add(bus["routeId"]);
      }
    }

    return routeIdList;
  }


  static Future<List<dynamic>> _callBusData(String keyword) async {
    Uri url;
    Map<String, dynamic> jsonBusData;
    List<dynamic> busData;


    url = Uri.parse(APIUrl.getBusListUrl(keyword));
    var response = await http.get(url);
    jsonBusData = jsonDecode((Xml2Json()..parse(response.body)).toParker());
    busData = JsonDecode.findListByKeyInMap("busRouteList", jsonBusData)
        ?? [JsonDecode.findMapByKeyInMap("busRouteList", jsonBusData)
            ?? {}];

    return busData;
  }
  
  static Future<List<String>> callStationList(String routeId) async {
    // routeId 이용하여 버스 정류장 데이터 호출 및 리스트 추출
    Uri url;
    Map<String, dynamic> jsonRouteData;
    List<dynamic> routeData;
    final List<String> stationList = [];
    
    url = Uri.parse(APIUrl.getRouteListUrl(routeId));
    var response = await http.get(url);
    jsonRouteData = jsonDecode((Xml2Json()..parse(response.body)).toParker());
    routeData = JsonDecode.findListByKeyInMap("busRouteStationList", jsonRouteData) ?? [];

    for (var station in routeData) {
      stationList.add(station["stationName"]);
    }

    return stationList;
  }
}