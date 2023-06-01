import 'package:busking/src/busRouteCard.dart';
import 'package:busking/src/myScrollBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/busRoute.dart';
import 'package:provider/provider.dart';
import '/provider/busSetProvider.dart';
import '/provider/stationDataProvider.dart';
import 'package:busking/main.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StationData>.value(value: stationData), // StationData 인스턴스를 Provider로 제공
        ChangeNotifierProvider<BusSetProvider>(create: (_) => BusSetProvider()), // BusSetProvider 인스턴스를 Provider로 제공
      ],
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



// 정류장 선택 페이지의 상단바 부분

class StationPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final busSetProvider = Provider.of<BusSetProvider>(context, listen: false);
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          var stationData = Provider.of<StationData>(context, listen: false);
          stationData.resetStations(); // 뒤로 가기 시, 선택된 정류장 리셋
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
                  busSetProvider.isBusSet = true;
                  print(busSetProvider.isBusSet);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
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

