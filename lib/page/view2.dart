import 'package:flutter/material.dart';
import 'package:practice_flutter/bloc/view-ctrl-bloc.dart';
import 'package:practice_flutter/home-contents.dart';
import 'package:practice_flutter/model/userModel.dart';
import 'package:practice_flutter/next_page.dart';
import 'package:practice_flutter/page/login.dart';
import 'package:practice_flutter/services/firestore/user_service.dart';
import '../mypage.dart';

class View2 extends StatefulWidget {
  final Stream<int> viewCtrl; //<-追加
  final String userId;
  View2({Key? key, required this.viewCtrl, required this.userId})
      : super(key: key); // <- streamの受け取り追加
  _View2 createState() => _View2();
}

class _View2 extends State<View2> {
  // 使用されない場合もある、初期化にコストがかかる変数をlateで宣言しておくと、その変数が使用されない場合は初期化もされないのでコスト削減できます。
  PageController? _pageController;
  late ViewCtrlBloc viewCtrl;
  String? userId;
  UserService userService = UserService();
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    viewCtrl = ViewCtrlBloc();
    _pageController = PageController(initialPage: 0); // 最初に表示するインデックス
    listenPage(); // <- インデックスの監視を追加
    getUserById();
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
      children: [HomeContents(), NextPage(user ?? {})],
    );
  }

  Future<void> getUserById() async {
    try {
      // print(widget.userId);
      Map user = await userService.getUserByUid(widget.userId);
      // print(user);
      setState(() {
        this.user = user as Map<String, dynamic>;
      });
    } catch (e) {
      print(e);
    }
  }

  // footerでボタンが押されたらインデックスが流れてくる
  listenPage() {
    widget.viewCtrl.listen((event) {
      // <- listenする
      _pageController!.animateToPage(event,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}
