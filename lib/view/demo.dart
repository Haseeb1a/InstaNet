import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instanet/helpers/app_colors.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  String username = '';
  String photoUrl = '';

  @override
  void initState() {
    // TODO: implement initState

    getUesername();
  }

  getUesername() async {
    var userSnap = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (userSnap.data() as Map<String, dynamic>)['username'];
      photoUrl = (userSnap.data() as Map<String, dynamic>)['photoUrl'];
    });
    print(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$username',
            style: TextStyle(color: primaryColor),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(
              photoUrl,
            ),
            radius: 40,
          ),
          Text(
            '$username',
            style: TextStyle(color: primaryColor),
          ),
        ],
      )),
    );
  }
}
