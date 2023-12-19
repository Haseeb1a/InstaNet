import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instanet/model/post_model.dart';
import 'package:instanet/services/firestore_method.dart';
import 'package:instanet/view/widgets/show_snackbar.dart';

class FeedController extends ChangeNotifier {
  int? commets = 0;
  List<Post> PostsDatas = [];
  // Future<Post>? postDatas;

  FeedController() {
    fecthDonorDatas();
    commets;
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

  fetchCommentLen(context, String postId) async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .get();
      commets = snap.docs.length;
    } catch (err) {
      showSnackBar(
        err.toString(),
        context,
      );
    }
    notifyListeners();
  }
  // liked and unliked
  void likeUp(postId, uid, likes) {
    FireStoreMethods().likePost(
      postId,
      uid,
      likes,
    );
  }
}
