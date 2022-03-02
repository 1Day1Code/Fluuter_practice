import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  // const NextPage({Key? key}) : super(key: key);

  NextPage(this.name);
  String name;
  @override
  State<NextPage> createState() => _MyHomePageState();
}

final myController = TextEditingController();

class _MyHomePageState extends State<NextPage> {
  String name = "";
  void _changeMessage(String newValue) {
    setState(() {
      name = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Container(
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.headline3,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: '名前',
                  ),
                  onChanged: _changeMessage,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: '趣味',
                  ),
                ),
                ElevatedButton(
                  child: Text('新規登録'),
                  onPressed: () {
                    name = myController.text;
                    // TODO: 新規登録
                  },
                ),
              ],
            )));
  }
}
