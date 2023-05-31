import 'package:busking/myAppBar.dart';
import 'package:busking/src/BusRouteCard.dart';
import 'package:busking/src/MyScrollBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/BusRoute.dart';

//ignore_for_file: prefer_const_constructors

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
      backgroundColor: Colors.white, // 배경을 흰색으로 지정
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
  String departureStation = ''; // 출발 정류장
  String arrivalStation = ''; // 도착 정류장

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      toolbarHeight: 100, // 원하는 높이로 설정
      title: Row(
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
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Color(0xFFf6f6f6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          departureStation,
                          style: TextStyle(fontSize: 16),
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
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color(0xFFf6f6f6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        arrivalStation,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /*
          ElevatedButton(
            //style: ButtonStyle(minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),),
            onPressed: () {
              // 버튼 클릭 시 실행될 동작
            },
            child: Text('알림 설정하기'),
          )
           */
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100); // AppBar의 높이 설정
}

