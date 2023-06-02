import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/stationDataProvider.dart';
import 'package:busking/model/busRoute.dart';
import 'package:busking/Screen/homeScreen/selectionBusPage/selectionBusPage.dart';
//ignore_for_file: prefer_const_constructors

class homeAfterSetBus extends StatelessWidget {
  const homeAfterSetBus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('알림설정 완료'),
      ],
    );
  }
}
