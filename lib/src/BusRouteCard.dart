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
      //출발, 도착 정류장 선택 시 색상 설정
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
            /*  클릭 시 알고리즘
            3개 이상 선택 불가
            출발->도착지 순으로 누를 수 있게 구현
            provider - update 함수로 출도착지 변수 업데이트
            */
            setState(() {
              if (widget.stationData.departureStation == stationName) {
                widget.stationData.updateDepartureStation('');
              } else if (widget.stationData.arrivalStation == stationName) {
                widget.stationData.updateArrivalStation('');
              } else if (widget.stationData.departureStation == '') {
                widget.stationData.updateDepartureStation(stationName);
              } else if (widget.stationData.arrivalStation == '') {
                widget.stationData.updateArrivalStation(stationName);
              }
            });
          },
        ),
      ),
    );
  }
}

