import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'busNumTextField.dart';
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
