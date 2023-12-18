import 'package:flutter/material.dart';
import 'package:instanet/services/firestore_method.dart';
import 'package:instanet/view/widgets/show_snackbar.dart';

class CommentController extends ChangeNotifier {
  final TextEditingController commentController = TextEditingController();

  getcommets(postId) {
    return FireStoreMethods().getCommentssview(postId);
  }


    void postComment(
        String uid, String name, String profilePic,context,postId,) async {
      try {
        String res = await FireStoreMethods().postComment(
          postId,
          commentController.text,
          uid,
          name,
          profilePic,
        );

        if (res != 'success') {
          if (context.mounted) showSnackBar(res, context);
        } else {
          // Provider.of<FeedController>(context,listen: false).getCommets(context,postId);
        }

        commentController.text = "";
        notifyListeners();

      } catch (err) {
        showSnackBar(
          err.toString(),
          context,
        );
      }
    }
  
}
