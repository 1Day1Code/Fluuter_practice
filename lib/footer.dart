import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final Sink<int> viewCtrl;

  Footer({Key? key, required this.viewCtrl}) : super(key: key); // <- sinkの受け取り

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State<Footer> {
  // ページのインデックス
  int pageIndex = 0;

  navigationItem() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Mypage',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: pageIndex,
      onTap: (_pageIndex) {
        setState(() {
          pageIndex = _pageIndex;
        });
        widget.viewCtrl.add(_pageIndex); // <- sinkにインデックスを流す
      },
      items: navigationItem(),
    );
  }
}
