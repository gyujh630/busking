import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/stationDataProvider.dart';
import 'package:busking/Screen/homeScreen/selectionStationPage/selectionStationPage.dart';
//ignore_for_file: prefer_const_constructors

class BusRouteCard extends StatefulWidget {
  final List<String> stationList;
  final int index;
  final StationData stationData; // StationData 인스턴스 추가

  const BusRouteCard({
    required this.stationList,
    required this.index,
    required this.stationData,
  });

  @override
  _BusRouteCardState createState() => _BusRouteCardState();
}

class _BusRouteCardState extends State<BusRouteCard> {
  @override
  Widget build(BuildContext context) {
    String stationName = widget.stationList[widget.index];
    bool isDepartureSelected = widget.stationData.departureStation == stationName;
    bool isArrivalSelected = widget.stationData.arrivalStation == stationName;

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
              if (widget.stationData.departureStation == stationName) {
                print(widget.stationData.departureStation + '-> 출발지 취소');
                widget.stationData.updateDepartureStation('');
              } else if (widget.stationData.arrivalStation == stationName) {
                print(widget.stationData.arrivalStation + '-> 도착지 취소');
                widget.stationData.updateArrivalStation('');
              } else if (widget.stationData.departureStation == '') {
                widget.stationData.updateDepartureStation(stationName);
                print(widget.stationData.departureStation + '-> 출발지 지정');
              } else if (widget.stationData.arrivalStation == '') {
                widget.stationData.updateArrivalStation(stationName);
                print(widget.stationData.arrivalStation + '-> 도착지 지정');
              }
            });
          },
        ),
      ),
    );
  }
}

