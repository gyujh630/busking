import 'package:busking/src/busNumberCard.dart';
import 'package:flutter/material.dart';
import 'package:busking/src/myScrollBehavior.dart';

class SelectionBusPage extends StatefulWidget {
  final List<String> busList;
  final List<String> routeIdList;

  const SelectionBusPage({Key? key, required this.busList, required this.routeIdList}) : super(key: key);

  @override
  State<SelectionBusPage> createState() => _SelectionBusPageState();
}

class _SelectionBusPageState extends State<SelectionBusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //배경색
      appBar: AppBar(
        backgroundColor: Colors.white, //Appbar 배경색
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ScrollConfiguration(
                behavior: MyScrollBehavior(),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: widget.busList.length,
                    itemBuilder: (context, index) {
                      return BusNumberCard(busList: widget.busList, routeIdList: widget.routeIdList, index: index);
                    }
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
