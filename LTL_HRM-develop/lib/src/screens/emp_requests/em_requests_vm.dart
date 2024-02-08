import 'package:flutter/material.dart';

class EmpRequestsVM extends ChangeNotifier {
  refresh() {
    notifyListeners();
  }
}
