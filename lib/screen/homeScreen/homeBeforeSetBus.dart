import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/stationDataProvider.dart';
import 'package:busking/model/busRoute.dart';
import 'package:busking/Screen/homeScreen/selectionBusPage/selectionBusPage.dart';
//ignore_for_file: prefer_const_constructors

/*
home - 버스 (알림 설정) 이전 화면
 */

class homeBeforeSetBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BusNumTextField(),
    );
  }
}


// 버스 번호 검색 textfield 부분
class BusNumTextField extends StatelessWidget {
  final _editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '알림 받을 버스를 검색하세요!',
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          width: 200,
          child: TextField(
            controller: _editController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "버스 번호 입력",
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            final busList = await BusRoute.callBusList(_editController.text);
            final routeIdList = await BusRoute.callRouteIdList(_editController.text);

            //해당하는 버스 번호가 없을 시
            if (busList.isEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('해당 버스 번호가 존재하지 않습니다.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('확인'),
                      ),
                    ],
                  );
                },
              );
            } else { //해당 번호가 있다면
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SelectionBusPage(busList: busList, routeIdList: routeIdList),
                ),
              );
            }
          },
          child: Text('검색'),
        )

      ],
    );
  }
}