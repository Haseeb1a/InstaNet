import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instanet/controller/bottombar_contoller.dart';
import 'package:instanet/controller/feed_controller.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:instanet/helpers/global_variable.dart';
import 'package:instanet/model/post_model.dart';
import 'package:instanet/view/widgets/post_card.dart';
import 'package:provider/provider.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  // String username = '';
  // String photoUrl = '';

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   getUesername();
  // }

  // getUesername() async {
  //   var userSnap = await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     username = (userSnap.data() as Map<String, dynamic>)['username'];
  //     photoUrl = (userSnap.data() as Map<String, dynamic>)['photoUrl'];
  //   });
  //   print(username);
  // }

  @override
  Widget build(BuildContext context) {
    final postData = Provider.of<FeedController>(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 32,
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: StreamBuilder(
      stream: postData.fetchPosts().snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
                
        // Use the postProvider.studentDatas instead of creating a new list
         List<Post> posts = snapshot.data?.docs.map((doc) => Post.fromSnap(doc)).toList() ?? [];
        // List<Post> studentDatas = postData.studentDatas;

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (ctx, index) => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username: ${posts[index].username}"),
                Text("Description: ${posts[index].description}"),
                // Add other Text widgets for additional properties
              ],
            ),
          ),
        );
  }));
  }
}
