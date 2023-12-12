import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instanet/controller/logincontroller.dart';
import 'package:instanet/services/firestore_method.dart';
import 'package:instanet/view/widgets/show_snackbar.dart';

class Addcontroller extends ChangeNotifier {
  LoginController logindata = LoginController();
  Uint8List? file;
  bool isLoading = false;
  final TextEditingController descriptionController = TextEditingController();

  // camera..
  pickfilecamera() async {
    Uint8List? files = await logindata.pickImage(ImageSource.camera);
    file = files;
    notifyListeners();
  }

  // from the gallery
  pickfilegallery() async {
    Uint8List? files = await logindata.pickImage(ImageSource.gallery);
    file = files;
    notifyListeners();
  }

  // postimage
  postImage(String uid, String username, String profImage,
      BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      String res = await FireStoreMethods().uploadPost(
          descriptionController.text, file!, uid, username, profImage);
      if (res == "success") {
        isLoading = false;
        notifyListeners();
        showSnackBar("posted", context);
        clearimage();
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  // clear image
  void clearimage() {
    file = null;
    notifyListeners();
  }
}
