import 'dart:convert';

import 'package:busking/JsonDecode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'APIUrl.dart';

import 'package:provider/provider.dart';
import 'provider/bottomNavigationBarProvider.dart';
import 'myAppBar.dart';
import 'Screen/homeScreen/homeMain.dart';
import 'Screen/myBusScreen/myBus.dart';


//ignore_for_file: prefer_const_constructors

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BusKing',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
        home: ChangeNotifierProvider<BottomNavigationBarProvider>.value(
            value: BottomNavigationBarProvider(),
            child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //const MyHomePage({super.key, required this.title});
  //final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [homeMain(), MyBus()];
    var _provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      appBar: MyAppBar(),
      body: screens[_provider.currentIdx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _provider.currentIdx,
        onTap: (index){
          _provider.currentIdx = index;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ("홈")),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus_filled_rounded), label: ("내 버스"))
        ],
      ),
    );
  }
}