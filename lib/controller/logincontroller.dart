import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instanet/resources/auth_mehods.dart';
import 'package:instanet/view/demo.dart';
import 'package:instanet/view/widgets/show_snackbar.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController biocontroller = TextEditingController();
  final TextEditingController usercontroller = TextEditingController();
  Uint8List? image;
  bool isloading = false;

  void selectimage() async {
    Uint8List? imageBytes = await pickImage(ImageSource.gallery);
    image = imageBytes;
    notifyListeners();
  }

  // pickimage function
  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      //  return  File(_file.path);
      return await _file.readAsBytes();
    }
    print('No image selected');
    return null;
  }

  void signUpUser(context) async {
    isloading = true;
    notifyListeners();
    String res = await AuthMethod().singUpuser(
        email: emailController.text,
        password: passwordController.text,
        username: usercontroller.text,
        bio: usercontroller.text,
        file: image!);
    print(res);
    isloading = false;
    notifyListeners();
    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  void loginUsers(context) async {
    isloading = true;
    notifyListeners();
    String res = await AuthMethod().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "success") {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: context)=>Demo());
    } else {
      showSnackBar('res', context);
    }
    isloading = false;
    notifyListeners();
  }
}
