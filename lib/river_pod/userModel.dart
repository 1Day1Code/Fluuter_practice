import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider<UserModel>(
  (ref) => UserModel(),
);

class UserModel extends ChangeNotifier {
  Map<String, dynamic> users = {};

  void getUser(user) {
    users = user;
    print(user);
    notifyListeners();
  }
}
