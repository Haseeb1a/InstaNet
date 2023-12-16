import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instanet/view/add_post_screen/add_post_screen.dart';
import 'package:instanet/view/demo.dart';
import 'package:instanet/view/feed_screen/feed_screen.dart';
import 'package:instanet/view/profile_screen/profile_screen.dart';
import 'package:instanet/view/search_screen/search_screen.dart';
import 'package:instanet/view/widgets/demolist.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(), 
  const SearchScreen(),
  const AddPostScreen(),
  DemoList(),

  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
