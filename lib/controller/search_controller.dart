import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instanet/model/user_model.dart';
import 'package:instanet/services/firestore_method.dart';

class SearchControllers extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool isShowUser = false;
  List<Users> userdata = [];

  // getUSers
 Future<void>   getusers() async {
    userdata = await FireStoreMethods().getSearchTime(searchController.text);
    notifyListeners();
  }

  SearchControllers() {
    isShowUser;
    notifyListeners();
  }

  checkuser() {
    isShowUser = true;
    notifyListeners();
    // if (searchController.text.isEmpty) {
    //   isShowUser = false;
    //   notifyListeners();
    // }
  }

  changerFall() {
    isShowUser = false;
    notifyListeners();
  }
}
