import 'package:busking/src/BusRouteCard.dart';
import 'package:busking/src/MyScrollBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/BusRoute.dart';
import 'package:provider/provider.dart';
import '/provider/stationDataProvider.dart';
//ignore_for_file: prefer_const_constructors


class SelectionStationPage extends StatefulWidget {
  final String routeId;

  const SelectionStationPage({Key? key, required this.routeId}) : super(key: key);

  @override
  State<SelectionStationPage> createState() => _SelectionStationPageState();
}

class _SelectionStationPageState extends State<SelectionStationPage> {
  final StationData stationData = StationData(); // StationData 인스턴스 생성

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StationData>(
      create: (context) => stationData, // StationData 인스턴스를 Provider로 제공
      child: Scaffold(
        appBar: StationPageAppBar(),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: BusRoute.callStationList(widget.routeId),
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ScrollConfiguration(
                        behavior: MyScrollBehavior(),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return BusRouteCard(
                              stationList: snapshot.data!,
                              index: index,
                              stationData: stationData, // StationData 인스턴스 전달
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}


class StationPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          var stationData = Provider.of<StationData>(context, listen: false);
          stationData.updateDepartureStation(''); // 뒤로 가기 시, 출발 정류장 초기화
          stationData.updateArrivalStation(''); // 뒤로 가기 시, 도착 정류장 초기화
          Navigator.of(context).pop();
        },
      ),
      toolbarHeight: 100,
      title: Consumer<StationData>(
        builder: (context, stationData, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            '출발 정류장',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Color(0xFFf6f6f6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            stationData.departureStation,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            '도착 정류장',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Color(0xFFf6f6f6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            stationData.arrivalStation,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: stationData.departureStation.isNotEmpty && stationData.arrivalStation.isNotEmpty
                    ? () {
                  // departureStation과 arrivalStation 변수에 값이 할당되어 있을 때만 최종 알림설정 버튼이 활성화되도록 설정
                }
                    : null,
                child: Text(
                  '설정',
                  style: TextStyle(fontSize: 13),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100); // 정류장 리스트 AppBar의 높이 설정
}

