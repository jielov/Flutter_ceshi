import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  //混入ChangeNotifier
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); //通知
  }
}
