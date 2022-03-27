import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/model/userModel.dart';
import 'package:practice_flutter/river_pod/testModel.dart';
import 'package:practice_flutter/river_pod/userModel.dart';
import 'package:practice_flutter/services/firestore/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class NextPage extends StatefulWidget {
  // const NextPage({Key? key}) : super(key: key);

  NextPage(this.user);
  final Map<String, dynamic> user;
  @override
  State<NextPage> createState() => _MyHomePageState();
}

final myController = TextEditingController();

class _MyHomePageState extends State<NextPage> {
  late String name = "";
  late String title = "";
  UserService userService = UserService();
  void _changeMessage(String newValue) {
    setState(() {
      name = newValue;
    });
  }

  void _regester() {
    userService.updateUserInfo(
        widget.user["docId"], name, widget.user["email"]);
  }

  @override
  void initState() {
    super.initState();
    // setState(() {
    // title = widget.user["userName"] as String;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer(builder: (context, ref, _) {
    // ref.watch(userProvider).user;
    // final user = useProvider(userProvider);
    return A(user: widget.user as Map<String, dynamic>);
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text("新規登録"),
    //     ),
    //     body: Container(
    // width: double.infinity,
    // child: Column(
    //   children: [
    //     Text(
    //       title,
    //       style: Theme.of(context).textTheme.headline3,
    //     ),
    //     TextField(
    //       decoration: InputDecoration(
    //         hintText: '名前',
    //       ),
    //       onChanged: _changeMessage,
    //     ),
    //     TextField(
    //       decoration: InputDecoration(
    //         hintText: '趣味',
    //       ),
    //     ),
    //     ElevatedButton(
    //       child: Text('登録する'),
    //       onPressed: _regester,
    //       // {
    //       // name = myController.text;

    //       // TODO: 新規登録
    //       // },
    //     ),

    //   ],
    // )
    // ));
    // });
  }
}

class A extends ConsumerWidget {
  final Map<String, dynamic> user;
  // const A({Key? key}) : super(key: key);
  A({required this.user});
  Widget build(BuildContext context, WidgetRef ref) {
    final int count = ref.watch(counterProvider).state;
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('$count')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(userProvider).getUser(user);
          },
        ),
      ),
    );
  }
}



// class Const {
//   static const routeNameUpsertTodo = 'upsert-todo';
// }

// class TodoListView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primaryColor: Colors.white),
//       routes: <String, WidgetBuilder>{
//         Const.routeNameUpsertTodo: (BuildContext context) => UpsertTodoView(),
//       },
//       home: TodoList(),
//     );
//   }
// }

// class TodoList extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todo'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () => _transitionToNextScreen(context),
//           ),
//         ],
//       ),
//       body: _buildList(),
//     );
//   }

//   Widget _buildList() {
//     final viewModel = useProvider(todoProvider);
//     // viewModelからtodoList取得/監視
//     final List<Todo> _todoList = viewModel.todoList;
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _todoList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return _dismissible(_todoList[index], context);
//       },
//     );
//   }

//   Widget _dismissible(Todo todo, BuildContext context) {
//     // ListViewのswipeができるwidget
//     return Dismissible(
//       // ユニークな値を設定
//       key: UniqueKey(),
//       confirmDismiss: (direction) async {
//         final confirmResult =
//             await _showDeleteConfirmDialog(todo.title, context);
//         // Future<bool> で確認結果を返す。False の場合削除されない
//         return confirmResult;
//       },
//       onDismissed: (DismissDirection direction) {
//         // viewModelのtodoList要素を削除
//         context.read(todoProvider).deleteTodo(todo.id);
//         // ToastMessageを表示
//         Fluttertoast.showToast(
//           msg: '${todo.title}を削除しました',
//           backgroundColor: Colors.grey,
//         );
//       },
//       // swipe中ListTileのbackground
//       background: Container(
//         alignment: Alignment.centerLeft,
//         // backgroundが赤/ゴミ箱Icon表示
//         color: Colors.red,
//         child: const Padding(
//           padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//           child: const Icon(
//             Icons.delete,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       child: _todoItem(todo, context),
//     );
//   }

//   Widget _todoItem(Todo todo, BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         border: const Border(bottom: BorderSide(width: 1, color: Colors.grey)),
//       ),
//       child: ListTile(
//         title: Text(
//           todo.title,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//           ),
//         ),
//         onTap: () {
//           _transitionToNextScreen(context, todo: todo);
//         },
//       ),
//     );
//   }

//   Future<void> _transitionToNextScreen(BuildContext context,
//       {Todo todo = null}) async {
//     final result = await Navigator.pushNamed(context, Const.routeNameUpsertTodo,
//         arguments: todo);

//     if (result != null) {
//       // ToastMessageを表示
//       Fluttertoast.showToast(
//         msg: result.toString(),
//         backgroundColor: Colors.grey,
//       );
//     }
//   }

//   Future<bool> _showDeleteConfirmDialog(
//       String title, BuildContext context) async {
//     final result = await showDialog<bool>(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('削除'),
//             content: Text('$titleを削除しますか？'),
//             actions: [
//               FlatButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 child: const Text('cancel'),
//               ),
//               FlatButton(
//                 onPressed: () => Navigator.of(context).pop(true),
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         });
//     return result;
//   }
// }