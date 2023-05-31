import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/stationData.dart';

class BusRouteCard extends StatefulWidget {
  final List<String> stationList;
  final int index;

  const BusRouteCard({Key? key, required this.stationList, required this.index})
      : super(key: key);

  @override
  State<BusRouteCard> createState() => _BusRouteCardState();
}

class _BusRouteCardState extends State<BusRouteCard> {
  @override
  Widget build(BuildContext context) {
    String stationName = widget.stationList[widget.index];

    return ChangeNotifierProvider<StationData>(
      create: (context) => StationData(),
      child: Consumer<StationData>(
        builder: (context, stationData, child) {
          bool isDepartureSelected = stationData.departureStation == stationName;
          bool isArrivalSelected = stationData.arrivalStation == stationName;
          print(stationData.departureStation +'-> 현재 출발지입니다');
          return Card(
            color: isDepartureSelected
                ? Colors.orange
                : isArrivalSelected
                ? Colors.blue
                : null,
            child: Center(
              child: ListTile(
                title: Text(
                  stationName,
                  style: TextStyle(fontSize: 13),
                ),
                subtitle: isDepartureSelected
                    ? Text('출발 정류장', style: TextStyle(fontSize: 10))
                    : isArrivalSelected
                    ? Text('도착 정류장', style: TextStyle(fontSize: 10))
                    : null,
                onTap: () {
                  setState(() {
                    if (isDepartureSelected) {
                      // 만약 해당 타일이 출발지로 되어 있다면, 출발지 선택 취소
                      stationData.updateDepartureStation('');
                      print(stationData.departureStation +'-> 출발지 취소');
                    } else if (isArrivalSelected) {
                      // 만약 해당 타일이 도착지로 되어 있다면, 도착지 선택 취소
                      stationData.updateArrivalStation('');
                      print(stationData.arrivalStation +'-> 도착지 취소');
                    } else if (stationData.departureStation == '') {
                      // 만약 해당 타일이 출발,도착지로 지정되어 있지 않고, 출발지 변수가 비어 있다면 해당 타일을 출발지로 지정
                      stationData.updateDepartureStation(stationName);
                      print(stationData.departureStation + '-> 출발지 지정');
                    } else if (stationData.arrivalStation == '') {
                      // 만약 해당 타일이 출발,도착지로 지정되어 있지 않고, 도착지 변수가 비어 있다면 해당 타일을 도착지로 지정
                      stationData.updateArrivalStation(stationName);
                      print(stationData.arrivalStation + '->도착지 지정');
                    }
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}