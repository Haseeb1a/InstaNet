import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instanet/controller/mobilephone_controller.dart';
import 'package:instanet/model/user_model.dart';
import 'package:instanet/view/bottom_bar/mobile_screen_layout.dart';
import 'package:instanet/view/login_page/widgets/details_page.dart';
import 'package:instanet/view/widgets/show_snackbar.dart';

class Userinfomation extends ChangeNotifier {
  final MobileController mobileControllers = MobileController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController biocontroller = TextEditingController();
  final TextEditingController usercontroller = TextEditingController();
  File? image;
  bool isloading = false;

  Future<void> selectImage(BuildContext context) async {
    image = await pickImage(context);
    notifyListeners();
  }

  // pick iamge
  Future<File?> pickImage(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(e.toString(), context);
    }

    return image;
  }

  void storeData(BuildContext context) {
   Users user = Users(
        email: emailController.text.trim(),
        uid: FirebaseAuth.instance.currentUser!.uid,
        photoUrl: '',
        username: usercontroller.text.trim(),
        bio: biocontroller.text,
        followers: [],
        following: []);

    if (image != null) {
      print('unnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnndddddddddddddddd');
      print(user.bio);
      print(user.email);
      print(user.uid);
      print(user.username);
      print(user.photoUrl);
      print(image);

      mobileControllers.savaUserDataToFirebase(
          context: context,
          usermodel: user,
           profilePic: image!,
          onSuccess: () {
            mobileControllers
                .saveUserDataToSP().then((value) => mobileControllers.setSignIn().then(
                (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>   MobileScreenLayout(),
                    ),
                    (route) => false),
              ));
          });
          // profilePic: image!,
          // onSuccess: () {

          //   mobileControllers

          //       .saveUserDataToSP().then((value) => mobileControllers.setSignIn().then(
          //       (value) => Navigator.pushAndRemoveUntil(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) =>   MobileScreenLayout(),
          //           ),
          //           (route) => false),
          //     ));
          // }
          // );
    } else {
      showSnackBar('please uplod your profilephoto', context);
    }
  }
}
