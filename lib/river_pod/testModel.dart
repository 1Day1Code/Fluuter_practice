import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = ChangeNotifierProvider<CountModel>(
  (ref) => CountModel(),
);

class CountModel extends ChangeNotifier {
  int state = 0;

  void incrementCounter() {
    state++;
    notifyListeners();
  }
}
