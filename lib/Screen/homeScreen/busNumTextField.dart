import 'package:flutter/material.dart';
import 'package:busking/model/BusRoute.dart';
import 'package:busking/Screen/SelectionBusPage.dart';

//ignore_for_file: prefer_const_constructors

class BusNumTextField extends StatelessWidget {
  final _editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '알림을 받을 버스를 검색하세요',
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
              final routeIdList = await BusRoute.callRouteIdList(_editController.text);   // TODO: routeId 리스트도 같이 넘겨줘서 BusNumberCard Class 에서 Page 넘어갈 때 routeId 를 넘겨줘야 된다.
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SelectionBusPage(busList: busList, routeIdList: routeIdList)
              ));
            },
            child: Text("확인"))
      ],
    );
  }
}
