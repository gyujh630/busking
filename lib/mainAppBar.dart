import 'package:flutter/material.dart';
import 'Screen/settingScreen/settingScreen.dart';
import 'main.dart';

/* 상단 앱바 */

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        /* 앱바 좌측 아이콘 부분
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(  //애니메이션 동작 없이 라우팅
              pageBuilder: (context, animation, secondaryAnimation) => MyApp(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          );
        },
         */
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
          child: Image.asset(
            'assets/images/crown.png',
          ),
        ),
      ),
      backgroundColor: Colors.white,
      actions: [ //앱바 우측 설정 아이콘 부분
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.black54,
            iconSize: 30.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ),
      ],
      titleSpacing: 0,
    );

  }
}