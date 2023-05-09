import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  List<int> counters = [0, 0, 0, 0];

  //using a higher-order function to calculate the total
  int get total => counters.reduce((value, element) => value + element);

  void setCounter(int index, int value)
  {
    counters[index] = value;
    notifyListeners();
  }
}