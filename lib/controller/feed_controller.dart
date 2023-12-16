import 'package:flutter/material.dart';
import 'package:instanet/model/post_model.dart';
import 'package:instanet/services/firestore_method.dart';

class FeedController extends ChangeNotifier {
  int? commets = 0;
  List<Post> studentDatas = [];

  FeedController() {
    fecthDonorDatas();
  }
  // getstudent
  Future<void> fecthDonorDatas() async {
    studentDatas = await FireStoreMethods().getSudents();
    notifyListeners();
  }

  // getCommets
  getCommets(context) async {
    commets = await FireStoreMethods()
        .getComments(context, studentDatas[commets!].postId);
    print('wwwwwwwwwwww$commets');
    notifyListeners();
  }
}
