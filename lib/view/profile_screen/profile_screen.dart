import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instanet/controller/profile_controller.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:instanet/model/post_model.dart';
import 'package:instanet/services/auth_mehods.dart';
import 'package:instanet/services/firestore_method.dart';
import 'package:instanet/view/login_page/login_screen.dart';
import 'package:instanet/view/widgets/follow_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  // var userData = {};
  @override
  Widget build(BuildContext context) {
    final pofiledata = Provider.of<ProfileController>(context, listen: false);
    // Provider.of<ProfileController>(context).uerDatails(
    //     widget.uid,
    //     pofiledata.postLen,
    //     pofiledata.userData,
    //     pofiledata.followers,
    //     pofiledata.following,
    //     pofiledata.isFollowing,
    //     context);

    Provider.of<ProfileController>(context, listen: false).getPosts(uid);
    Provider.of<ProfileController>(
      context,
    ).getData(uid, context);
    print('tttttttttttttt$uid');

    return pofiledata.userData.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Consumer<ProfileController>(
                builder: (context, value, child) {
                  return Text(
                    value.userData['username'],
                  );
                },
              ),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Consumer<ProfileController>(
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                  value.userData['photoUrl'] ?? '',
                                ),
                                radius: 40,
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        buildStatColumn(
                                            value.posts.length, "posts"),
                                        buildStatColumn(
                                            value.followers, "followers"),
                                        buildStatColumn(
                                            value.following, "following"),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FirebaseAuth.instance.currentUser!
                                                    .uid ==
                                                uid
                                            ? FollowButton(
                                                text: 'Sign Out',
                                                backgroundColor:
                                                    mobileBackgroundColor,
                                                textColor: primaryColor,
                                                borderColor: Colors.grey,
                                                function: () async {
                                                  await AuthMethod().signOut();
                                                  if (context.mounted) {
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginScreen(),
                                                      ),
                                                    );
                                                  }
                                                },
                                              )
                                            : value.isFollowing
                                                ? FollowButton(
                                                    text: 'Unfollow',
                                                    backgroundColor:
                                                        Colors.white,
                                                    textColor: Colors.black,
                                                    borderColor: Colors.grey,
                                                    function: () async {
                                                      await FireStoreMethods()
                                                          .followUser(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        value.userData['uid'],
                                                      );

                                                      value.followdecrement();
                                                    },
                                                  )
                                                : FollowButton(
                                                    text: 'Follow',
                                                    backgroundColor:
                                                        Colors.blue,
                                                    textColor: Colors.white,
                                                    borderColor: Colors.blue,
                                                    function: () async {
                                                      await FireStoreMethods()
                                                          .followUser(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        value.userData['uid'],
                                                      );

                                                      value.followicrement();
                                                    },
                                                  )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: Text(
                              value.userData['username'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              top: 1,
                            ),
                            child: Text(
                              value.userData['bio'],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(),
                Consumer<ProfileController>(builder: (context, value, index) {
                  if (value.posts.isEmpty) {
                    return const Center(
                      child: Text(' no post'),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: value.posts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 1.5,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final Post snap = value.posts[index];

                      return SizedBox(
                        child: Image(
                          image: NetworkImage(snap.postUrl),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                })
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
