import 'package:flutter/material.dart';
import 'package:practice_flutter/bloc/view-ctrl-bloc.dart';
import 'package:practice_flutter/footer.dart';
import 'package:practice_flutter/header.dart';
import 'package:practice_flutter/home-contents.dart';
import 'package:practice_flutter/page/view.dart';
import 'package:practice_flutter/page/view2.dart';

// [Themelist] インスタンスにおける処理。
class Home extends StatefulWidget {
  final String user_id;
  final Stream<int> viewCtrl; //<-追加

  Home({Key? key, required this.user_id, required this.viewCtrl});
  @override
  _Home createState() => _Home(user_id);
}

class _Home extends State<Home> {
  _Home(this.user_id);
  late ViewCtrlBloc viewCtrl;
  // late ViewCtrlBloc viewCtrl;
  final String user_id;
  PageController? _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: Header(),
      // <- 受け取るためにstreamを渡す
      body: View2(viewCtrl: viewCtrl.viewStream),
      //  <- 受け取るためにstreamを渡す
      bottomNavigationBar: Footer(viewCtrl: viewCtrl.viewSink),
      // <- インデックスを流すためにsinkを渡す
    );
    return PageView(
      controller: _pageController,
      children: [
        HomeContents(),
        Text('ようこそ2',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(user_id),
        // View(viewCtrl: viewCtrl.viewStream)
      ],
      // bottomNavigationBar: Footer(viewCtrl: viewCtrl.viewSink)
    );
  }

  @override
  void initState() {
    super.initState();
    viewCtrl = ViewCtrlBloc();
    //  <-Blocをインスタンス化
    _pageController = PageController(initialPage: 0); // 最初に表示するインデックス
    listenPage();
    super.initState();
  }

  @override
  void dispose() {
    viewCtrl.dispose();
    //  <- 忘れずdispose
    super.dispose();
  }

  listenPage() {
    widget.viewCtrl.listen((event) {
      // <- listenする
      print(event);
      _pageController!.animateToPage(event,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}
