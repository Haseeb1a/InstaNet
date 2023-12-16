import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:instanet/model/post_model.dart';
import 'package:instanet/model/user_model.dart';
import 'package:instanet/helpers/storage_method.dart';
import 'package:instanet/view/widgets/show_snackbar.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //  fetch posts
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');
  Future<List<Post>> getSudents() async {
    final snapshot = await posts.orderBy('datePublished', descending: true).get();
    return snapshot.docs.map((doc) {
      print(doc);
      return Post.fromSnap(doc, doc.id);
    }).toList();
  }

  // getpostProfile
  Future<List<Post>> getPostProfile(uid) async {
    final snapshot = await posts.where('uid', isEqualTo: uid).get();
    return snapshot.docs.map((doc) {
      print(doc);
      return Post.fromSnap(doc, doc.id);
    }).toList();
  }

  Future<List?> userLengthDetais(uid, postLen, userData, followers, following,
      isFollowing, context) async {
    try {
      var userSnap =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      List lenths = [postLen,userData,followers,following, isFollowing];
      return lenths;

      // setState(() {});
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
      return null;
    }
  }

  //  getSearachtime
  Future<List<Users>> getSearchTime(String text) async {
    final snapshot = await posts.firestore
        .collection('user')
        .where(
          'username',
          isGreaterThanOrEqualTo: text,
        )
        .get();
    return snapshot.docs.map((doc) {
      print(doc);
      return Users.fromSnap(doc);
    }).toList();
  }

  // upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "some error occured";
    try {
      String postUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          likes: [],
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: postUrl,
          profImage: profImage);
      firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // post comments
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await firestore.collection('user').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await firestore.collection('user').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await firestore.collection('user').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await firestore.collection('user').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await firestore.collection('user').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  // getcommets
  Future<int?> getComments(context, postId) async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .get();
      int comments = snap.docs.length;
      return comments;
    } catch (e) {
      showSnackBar(e.toString(), context);
      return null;
      // setState(() {});
    }
  }

  // delete the post
  Future<void> deletePost(String PostId) async {
    try {
      await firestore.collection('posts').doc(PostId).delete();
    } catch (err) {
      print(err.toString());
    }
  }
}
