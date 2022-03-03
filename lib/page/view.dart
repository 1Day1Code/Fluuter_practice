import 'package:flutter/material.dart';
import 'package:practice_flutter/home-contents.dart';
import '../mypage.dart';

class View extends StatefulWidget {
  final Stream<int> viewCtrl; //<-追加

  View({Key? key, required this.viewCtrl})
      : super(key: key); // <- streamの受け取り追加
  _View createState() => _View();
}

class _View extends State<View> {
  // 使用されない場合もある、初期化にコストがかかる変数をlateで宣言しておくと、その変数が使用されない場合は初期化もされないのでコスト削減できます。
  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0); // 最初に表示するインデックス
    listenPage(); // <- インデックスの監視を追加
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [HomeContents(), Mypage()],
    );
  }

  // footerでボタンが押されたらインデックスが流れてくる
  listenPage() {
    widget.viewCtrl.listen((event) {
      // <- listenする
      print(event);
      _pageController!.animateToPage(event,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}
