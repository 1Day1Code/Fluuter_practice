import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_flutter/bloc/view-ctrl-bloc.dart';
import 'package:practice_flutter/registration.dart';
// import 'authentication_error.dart';
import '/registration.dart';
import '../home.dart';

class Login extends StatefulWidget {
  final Stream<int> viewCtrl; //<-追加
  Login({Key? key, required this.viewCtrl});
  // Login(this.login_Email, this.login_Password);
  // String login_Email
  // String login_Password
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  String login_Email = ""; // 入力されたメールアドレス
  String login_Password = ""; // 入力されたパスワード
  String infoText = ""; // ログインに関する情報を表示

  // Firebase Authenticationを利用するためのインスタンス
  final FirebaseAuth auth = FirebaseAuth.instance;
  // final firebase = Firebase.initializeApp();
  late UserCredential userCredential;
  late ViewCtrlBloc viewCtrl;
  late User user;

  @override
  void initState() {
    viewCtrl = ViewCtrlBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _changeLoginEmail(String value) {
    setState(() {
      login_Email = value;
    });
  }

  void _changeLoginPassWord(String value) {
    setState(() {
      login_Password = value;
    });
  }

  void login() async {
    try {
      // メール/パスワードでユーザー登録
      userCredential = await auth.signInWithEmailAndPassword(
        email: login_Email,
        password: login_Password,
      );

      // ログイン成功
      // ログインユーザーのIDを取得
      user = userCredential.user!;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Home(user_id: user.uid, viewCtrl: viewCtrl.viewStream),
          ));
    } catch (e) {
      // ログインに失敗した場合
      setState(() {
        // infoText = auth_error.login_error_msg(e.code);
      });
    }
  }

  // エラーメッセージを日本語化するためのクラス
  // final auth_error = Authentication_error();

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // メールアドレスの入力フォーム
            Padding(
                padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "メールアドレス"),
                  onChanged: _changeLoginEmail,
                )),

            // パスワードの入力フォーム
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 10.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "パスワード（8～20文字）"),
                obscureText: true, // パスワードが見えないようRにする
                maxLength: 20, // 入力可能な文字数
                maxLengthEnforced: false, // 入力可能な文字数の制限を超える場合の挙動の制御
                onChanged: _changeLoginPassWord,
              ),
            ),

            // ログイン失敗時のエラーメッセージ
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
              child: Text(
                infoText,
                style: TextStyle(color: Colors.red),
              ),
            ),

            ButtonTheme(
              minWidth: 350.0,
              // height: 100.0,
              child: RaisedButton(
                child: Text(
                  'ログイン',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: Colors.white,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: login,
              ),
            ),
          ],
        ),
      ),

      // 画面下にボタンの配置
      bottomNavigationBar:
          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonTheme(
            minWidth: 350.0,
            // height: 100.0,
            child: RaisedButton(
                child: Text(
                  'アカウントを作成する',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: Colors.blue,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                // ボタンクリック後にアカウント作成用の画面の遷移する。
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (BuildContext context) => Registration(),
                    ),
                  );
                }),
          ),
        ),
      ]),
    );
  }

  // listenPage() {
  //   widget.viewCtrl.listen((event) {
  //     // <- listenする
  //     print(event);
  //     _pageController!.animateToPage(event,
  //         duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  //   });
  // }
}
