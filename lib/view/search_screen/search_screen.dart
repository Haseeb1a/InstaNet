import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instanet/controller/feed_controller.dart';
import 'package:instanet/controller/search_controller.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:instanet/model/post_model.dart';
import 'package:instanet/model/user_model.dart';
import 'package:instanet/view/profile_screen/profile_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // final TextEditingController searchController = TextEditingController();
  // bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchControllers>(context).getusers();
    final SearchProvider = Provider.of<SearchControllers>(context);
    final postProvider = Provider.of<FeedController>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Form(
            child: TextFormField(
              controller: SearchProvider.searchController,
              decoration:
                  const InputDecoration(labelText: 'Search for a user...'),
              onFieldSubmitted: (String _) {
                SearchProvider.checkuser();
              },
            ),
          ),
        ),
        body: SearchProvider.isShowUser
            ? Consumer<SearchControllers>(builder: (context, value, index) {
                if (value.userdata.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: value.userdata.length,
                  itemBuilder: (context, index) {
                    final Users snap = value.userdata[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              uid: snap.uid,
                            ),
                          ),
                        );
                        SearchProvider.changerFall();
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            snap.photoUrl,
                          ),
                          radius: 16,
                        ),
                        title: Text(
                          snap.username,
                        ),
                      ),
                    );
                  },
                );
              }

                // ? FutureBuilder(
                //     future: FirebaseFirestore.instance
                //         .collection('user')
                //         .where(
                //           'username',
                //           isGreaterThanOrEqualTo:
                //               SearchProvider.searchController.text,
                //         )
                //         .get(),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //       return ListView.builder(
                //         itemCount: (snapshot.data! as dynamic).docs.length,
                //         itemBuilder: (context, index) {
                //           return InkWell(
                //             onTap: () {
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                   builder: (context) => ProfileScreen(
                //                     uid: (snapshot.data! as dynamic).docs[index]
                //                         ['uid'],
                //                   ),
                //                 ),
                //               );
                //               SearchProvider.changerFall();
                //             },
                //             child: ListTile(
                //               leading: CircleAvatar(
                //                 backgroundImage: NetworkImage(
                //                   (snapshot.data! as dynamic).docs[index]
                //                       ['photoUrl'],
                //                 ),
                //                 radius: 16,
                //               ),
                //               title: Text(
                //                 (snapshot.data! as dynamic).docs[index]['username'],
                //               ),
                //             ),
                //           );
                //         },
                //       );
                //     },
                //   )
                )
            : Consumer<FeedController>(builder: (context, value, index) {
                // future: FirebaseFirestore.instance
                //     .collection('posts')
                //     .orderBy('datePublished')
                //     .get(),
                // builder: (context, snapshot) {
                // if (!snapshot.hasData) {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }

                return MasonryGridView.count(
                  crossAxisCount: 3,
                  itemCount: value.studentDatas.length,
                  itemBuilder: (context, index) {
                    final Post snap = value.studentDatas[index];
                    return Image.network(
                      snap.postUrl,
                      fit: BoxFit.cover,
                    );
                  },
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                );
              }));
  }
}
