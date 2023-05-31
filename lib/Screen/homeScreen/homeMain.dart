import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:busking/model/BusRoute.dart';
import 'package:busking/Screen/homeScreen/selectionBusPage/selectionBusPage.dart';
//ignore_for_file: prefer_const_constructors


/*
 Home - MultiProvider로 state 관리 구현 필요
*/

class homeMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusSearchProvider()),
        ChangeNotifierProvider(create: (_) => BusListProvider()),
        ChangeNotifierProvider(create: (_) => BusInfoProvider()),
      ],
      child: Scaffold(
        body: BusSearchScreen(),
      ),
    );
  }
}

class BusSearchProvider with ChangeNotifier {
  // 버스 검색
}

class BusListProvider with ChangeNotifier {
  // 버스 리스트
}

class BusInfoProvider with ChangeNotifier {
  // 버스 정보
}

class BusSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // BusSearchProvider, BusListProvider, BusInfoProvider에 접근하여 상태 사용
    final busSearchProvider = Provider.of<BusSearchProvider>(context);
    final busListProvider = Provider.of<BusListProvider>(context);
    final busInfoProvider = Provider.of<BusInfoProvider>(context);

    return Center(
      child: BusNumTextField(),
    );
  }
}

class BusListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final busListProvider = Provider.of<BusListProvider>(context);

    return Container(
      // 버스 리스트 표시
      child: Text('버스 리스트 화면'),
    );
  }
}

class BusInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final busInfoProvider = Provider.of<BusInfoProvider>(context);

    return Container(
      // 버스 정보(노선)
    );
  }
}

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
              final routeIdList = await BusRoute.callRouteIdList(_editController.text);   // TODO: routeId 리스트도 같이 넘겨줘서 BusNumberCard Class 에서 Page 넘어갈 때 routeId 를 넘겨줘야 된다.
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SelectionBusPage(busList: busList, routeIdList: routeIdList)
              ));
            },
            child: Text("검색"))
      ],
    );
  }
}
