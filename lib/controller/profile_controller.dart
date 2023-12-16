import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instanet/model/post_model.dart';
import 'package:instanet/services/firestore_method.dart';
import 'package:instanet/view/widgets/show_snackbar.dart';

class ProfileController extends ChangeNotifier {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  List<Post> posts = [];
  List? usersData = [];

  followdecrement() {
    isFollowing = false;
    notifyListeners();
    followers--;
    notifyListeners();
  }

  followicrement() {
    isFollowing = true;
    notifyListeners();
    followers++;
    notifyListeners();
  }

  getPosts(uid) async {
    posts = await FireStoreMethods().getPostProfile(uid);
  }

  // uerDatails(uids, postLens, userDatas, followerss, followings, isFollowings,
  //     context) async {
  //   // isLoading = true;
  //   // notifyListeners();

  //   usersData = (await FireStoreMethods().userLengthDetais(uids, postLens,
  //       userDatas, followers, followings, isFollowings, context))!;
  //   print('hhhhhhhhhhhhhhhhhhhhhhhhh${usersData![2]}');

  //   postLen = usersData![0] ?? 0;
  //   userData = usersData![1] ?? {};
  //   followers = usersData![2] ?? 0;
  //   following = usersData![3] ?? 0;
  //   isFollowing = usersData![4] ?? false;

  //   isLoading = false;
  //   notifyListeners();
  //   print('gggggggggggggggggggg$isLoading');
  // }

  getData(uid, context) async {
    // setState(() {
    isLoading = true;
    notifyListeners();
    // });
    try {
      var userSnap =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();

      // get post lENGTH
       var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      print("xxxxxxxxxxxxxxxx$postSnap");
      postLen = postSnap.docs.length;
      print('ZZZZZZZZZZZZZZZZZZZZZZZZZZZZ$postLen');
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      // print(isFollowing);
      notifyListeners();
      // setState(() {});
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
    }
    // setState(() {
    isLoading = false;
    notifyListeners();
    // });
  }
}
