import 'package:flutter/material.dart';
import 'package:practice_flutter/river_pod/testModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeContents extends ConsumerWidget {
  HomeContents({Key? key}) : super(key: key);
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Consumer(builder: (context, ref, _) {
          final count = ref.watch(counterProvider).state; // ④状態の監視と取得
          return Text('$count',
              style: TextStyle(fontSize: 150, color: Colors.lightBlueAccent));
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ⑤状態の更新
          ref.read(counterProvider).incrementCounter(); // 1加算する
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// 表示部分（ページ側）を作る
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final helloWorldProvider = Provider((ref) => 'Hello World');
    // Modelを読み込み
    // final countModel = context.read(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod テスト'),
      ),
      // bodyの表示
      body: Center(
        child: Consumer(builder: (context, watch, _) {
          // データを取得する
          final counter = watch.watch(helloWorldProvider);
          // final counter = watch(helloWorldProvider);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'クリックの回数',
              ),
              // 取得したデータを表示する
              Text(
                '$counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          );
        }),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: countModel.incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Widget test() {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.green,
          height: 150,
          width: 150,
        ),
        Container(
          color: Colors.blue,
          height: 75,
          width: 75,
        ),
        Container(
          color: Colors.red,
          height: 50,
          width: 50,
        ),
      ],
    );
  }

// a() {
//   Column(
//     children: <Widget>[
//       Expanded(
//         child: ListView(
//           children: <Widget>[
//             Text(
//               "item1",
//               style: TextStyle(fontSize: 30),
//             ),
//             Text(
//               "item2",
//               style: TextStyle(fontSize: 30),
//             ),
//             Text(
//               "item3",
//               style: TextStyle(fontSize: 30),
//             ),
//             Text(
//               "item4",
//               style: TextStyle(fontSize: 30),
//             ),
//             Text(
//               "item5",
//               style: TextStyle(fontSize: 30),
//             ),
//             Text(
//               "item6",
//               style: TextStyle(fontSize: 30),
//             ),
//           ],
//         ),
//       ),
//       Container(height: 200, color: Colors.grey)
//     ],
//   );
// }
}
