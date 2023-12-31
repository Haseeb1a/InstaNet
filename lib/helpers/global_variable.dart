import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instanet/view/add_post_screen/add_post_screen.dart';

import 'package:instanet/view/feed_screen/feed_screen.dart';
import 'package:instanet/view/profile_screen/profile_screen.dart';
import 'package:instanet/view/search_screen/search_screen.dart';


const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(), 
  const SearchScreen(),
  const AddPostScreen(),

  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
