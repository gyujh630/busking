import 'package:flutter/material.dart';
//ignore_for_file: prefer_const_constructors


/* 내 버스 화면 - Provider로 상태 관리 구현 필요 (1. 버스 선택 전, 2. 버스 선택 후)*/

class MyBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              alignment: Alignment.center,
              child: Column(                               //img (잠시 지워둠)
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.6,
                  child: Image.asset(
                    'assets/images/crying_bus.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(height: 10),
              const Opacity(
                opacity: 0.6,
                child: Text('선택된 버스가 없습니다.'),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}
