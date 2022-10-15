import 'package:flutter/material.dart';

class ScrollProvider with ChangeNotifier {
  bool _lastStatus = true;

  bool get lastStatus => _lastStatus;

  changeLastStatus(bool v) {
    _lastStatus = v;

    notifyListeners();
  }
}
