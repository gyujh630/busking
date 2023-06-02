import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/busSetprovider.dart';
import '/provider/stationDataProvider.dart';
import 'homeBeforeSetBus.dart';
import 'homeAfterSetBus.dart';
import 'selectionStationPage/selectionStationPage.dart';
//ignore_for_file: prefer_const_constructors

/*
 home 메인 부분
*/

class homeMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: BusSetProvider(),
      child: Consumer<BusSetProvider>(
        builder: (context, busSetProvider, _) {
          final isBusSet = busSetProvider.isBusSet;
          return Scaffold(
            body: isBusSet ? homeAfterSetBus() : homeBeforeSetBus(),
          );
        },
      ),
    );
  }
}

/* isBusSet 테스트용
class homeMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: BusSetProvider(),
      child: Consumer<BusSetProvider>(
        builder: (context, busSetProvider, _) {
          final isBusSet = busSetProvider.isBusSet;
          print('isBusSet: $isBusSet'); // 테스트용 print 문
          return Scaffold(
            body: isBusSet ? homeAfterSetBus() : homeBeforeSetBus(),
          );
        },
      ),
    );
  }
}

 */