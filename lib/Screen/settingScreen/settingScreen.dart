import 'package:flutter/material.dart';

//ignore_for_file: prefer_const_constructors

/* 설정 화면 */

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        title: Text('설정'),
      ),
      body: Center(
        child: Text('설정 화면'),
      ),
    );
  }
}