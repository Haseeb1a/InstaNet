import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instanet/model/post_model.dart';
import 'package:instanet/services/firestore_method.dart';
import 'package:instanet/view/demo.dart';

class FeedController extends ChangeNotifier {
  int? commets = 0;
  List<Post> PostsDatas = [];
  // Future<Post>? postDatas;

  FeedController() {
    fecthDonorDatas();
    PostsDatas;
    notifyListeners();
  }
  // getstudent
  Future<void> fecthDonorDatas() async {
    // studentDatas = await FireStoreMethods().getSudents();
    PostsDatas = await FireStoreMethods().getSudents();
    notifyListeners();
  }

  // getCommets
  getCommets(context, postId) async {
    commets = await FireStoreMethods().getComments(context, postId);
    print('wwwwwwwwwwww$commets');
    notifyListeners();
  }

  // // demo-----------------------
  fetchPosts() {
    return FireStoreMethods().getPosts();
  }
}
