import 'package:flutter/material.dart';

class SearchControllers extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool isShowUser = false;

  checkuser() {
    isShowUser = true;
    notifyListeners();
  }
}
