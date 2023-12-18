import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instanet/controller/animation_controller.dart';
import 'package:instanet/controller/feed_controller.dart';
import 'package:instanet/controller/user_provider.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:instanet/model/post_model.dart';
import 'package:instanet/model/user_model.dart';
import 'package:instanet/services/firestore_method.dart';
import 'package:instanet/view/commet_screen/comment_screen.dart';
import 'package:instanet/view/widgets/like_animation.dart';
import 'package:instanet/view/widgets/show_snackbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DemoList extends StatefulWidget {
  // final snap;
  DemoList({
    super.key,
  });

  @override
  State<DemoList> createState() => _DemoListState();
}

class _DemoListState extends State<DemoList> {
  bool isLikeAnimaion = false;

  // int comments = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // postDasta.getCommets(context,postDasta.studentDatas[comments].postId);
  }
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getComments();
  // }

  // void getComments() async {
  //   try {
  //     QuerySnapshot snap = await FirebaseFirestore.instance
  //         .collection('posts')
  //         .doc(widget.snap['PostId'])
  //         .collection('comments')
  //         .get();
  //     comments = snap.docs.length;
  //   } catch (e) {
  //     showSnackBar(e.toString(), context);
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<FeedController>(context, listen: false).getCommets(context);
    final postDasta = Provider.of<FeedController>(context);
    final Users user = Provider.of<UserProvider>(context).getUser;
    
    final data = Provider.of<AnimatioinController>(
      context,
    );
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        // title:
        // AppBarTitile(firstName: 'Stud', secondName: 'ents ')
      ),
      body: Consumer<FeedController>(builder: (context, value, index) {
        if (value.PostsDatas.isEmpty) {
          return const Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.people_sharp,
                    color: Colors.white,
                    size: 40,
                  )),
              SizedBox(
                width: 8,
              ),
              Text(
                'ADD student',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ));
        }
        return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ListView.builder(
                itemCount: value.PostsDatas.length,
                itemBuilder: (context, index) {
                  final Post snap = value.PostsDatas[index];
                  return Container(
                    color: mobileBackgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16)
                              .copyWith(right: 0),
                          // header section

                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(snap.profImage),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snap.username,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              child: ListView(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .symmetric(
                                                          vertical: 16),
                                                  shrinkWrap: true,
                                                  children: [
                                                    'Delete',
                                                  ]
                                                      .map((e) => InkWell(
                                                            onTap: () {
                                                              FireStoreMethods()
                                                                  .deletePost(snap
                                                                      .postId);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              child: Text(e),
                                                            ),
                                                          ))
                                                      .toList()),
                                            ));
                                  },
                                  icon: const Icon(Icons.more_vert))
                            ],
                          ),
                          // image section
                        ),
                        GestureDetector(
                          onDoubleTap: () async {
                            await FireStoreMethods().likePost(
                              snap.postId.toString(),
                              user.uid,
                              snap.likes,
                            );
                            data.changer();
                            postDasta.fecthDonorDatas();
                          },
                          child: Stack(alignment: Alignment.center, children: [
                            SizedBox(
                              height: height * 0.35,
                              width: double.infinity,
                              child: Image.network(
                                snap.postUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: data.isAnimating ? 1 : 0,
                              child: LikeAnimation(
                                child: const Icon(
                                  Icons.favorite,
                                  color: primaryColor,
                                  size: 100,
                                ),
                                isAnimating: data.isAnimating,
                                duration: const Duration(milliseconds: 400),
                                onEnd: () {
                                  data.changers();
                                },
                              ),
                            )
                          ]),
                        ),

                        // like comment share
                        Row(
                          children: [
                            LikeAnimation(
                              isAnimating: snap.likes.contains(user.uid),
                              smallLike: true,
                              child: IconButton(
                                  onPressed: () async {
                                    await FireStoreMethods().likePost(
                                      snap.postId.toString(),
                                      user.uid,
                                      snap.likes,
                                    );
                                  },
                                  icon: snap.likes.contains(user.uid)
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                          color: primaryColor,
                                        )),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CommentsScreen(
                                        postId: snap.postId.toString(),
                                      ),
                                    ));
                                 postDasta.getCommets(context);
                              },
                              icon: const Icon(Icons.comment_outlined),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.send),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.bookmark_border)),
                            ))
                          ],
                        ),
                        // discaription ,number on commnet
                        Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.w800),
                                child: Text(
                                  '${snap.likes.length} likes',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(top: 8),
                                child: RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                          color: primaryColor,
                                        ),
                                        children: [
                                      TextSpan(
                                          text: snap.username,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                        text: snap.description,
                                      )
                                    ])),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          vertical: 4),
                                  width: double.infinity,
                                  child: Text(
                                    'view all ${postDasta.commets} comments ',
                                    style: const TextStyle(
                                        fontSize: 16, color: secondaryColor),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    vertical: 4),
                                width: double.infinity,
                                child: Text(
                                  DateFormat.yMMMd().format(snap.datePublished),
                                  style: const TextStyle(
                                    color: secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }));
      }),
    );
  }
}
