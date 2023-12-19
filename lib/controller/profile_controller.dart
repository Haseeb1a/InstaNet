import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instanet/model/post_model.dart';
import 'package:instanet/services/auth_mehods.dart';
import 'package:instanet/services/firestore_method.dart';
import 'package:instanet/view/widgets/show_snackbar.dart';

class ProfileController extends ChangeNotifier {
  var userData = {};
  // int postLen =0 ;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  List<Post> posts = [];
  // postLen=posts.length;
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

  getData(uid, context) async {
    isLoading = true;
    notifyListeners();

    usersData = (await FireStoreMethods().userLengthDetais(
        uid, userData, followers, following, isFollowing, context))!;

    userData = usersData![0] ?? {};
    followers = usersData![1] ?? 0;
    following = usersData![2] ?? 0;
    isFollowing = usersData![3] ?? false;

    isLoading = false;
    notifyListeners();
  }

  followandfolling(String uid, String followId) async {
    await FireStoreMethods().followUser(uid, followId);
  }

  // singout
  void singOut() async {
    await AuthMethod().signOut();
  }
}
