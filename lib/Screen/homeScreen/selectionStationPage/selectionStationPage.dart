import 'package:busking/mainAppBar.dart';
import 'package:busking/src/BusRouteCard.dart';
import 'package:busking/src/MyScrollBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/BusRoute.dart';

//ignore_for_file: prefer_const_constructors

/* 전역변수 */
String departureStation = ''; // 출발 정류장
String arrivalStation = ''; // 도착 정류장

class SelectionStationPage extends StatefulWidget {
  final String routeId;
  const SelectionStationPage({Key? key, required this.routeId}) : super(key: key);
  @override
  State<SelectionStationPage> createState() => _SelectionStationPageState();
}

class _SelectionStationPageState extends State<SelectionStationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            return BusRouteCard(stationList: snapshot.data!, index: index);
                          }
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
          //뒤로 가기 누를 시 선택 정류장 값 초기화
          departureStation = '';
          arrivalStation = '';
          Navigator.of(context).pop();
        },
      ),
      toolbarHeight: 100,
      title: Row(
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
                          departureStation,
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
                        arrivalStation,
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: departureStation.isNotEmpty && arrivalStation.isNotEmpty ? () {
              // departureStation과 arrivalStation 변수에 값이 할당되어 있을 때만 최종 알림설정 버튼이 활성화되도록 설정
            } : null,
            child: Text('설정', style: TextStyle(fontSize: 13),),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100); // 정류장 리스트 AppBar의 높이 설정
}

