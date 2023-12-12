import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instanet/services/auth_mehods.dart';
import 'package:instanet/view/bottom_bar/mobile_screen_layout.dart';
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


  // singupControlers
  void signUpUser(context) async {
    isloading = true;
    notifyListeners();

    String res = await AuthMethod().singUpuser(
        email: emailController.text,
        password: passwordController.text,
        username: usercontroller.text,
        bio: biocontroller.text,
        file: image!);
    print(res);
    if (res == "success") {
      isloading = false;
      emailController.clear;
      biocontroller.clear;
      passwordController.clear;
      notifyListeners();
    } else {
      isloading = false;
      notifyListeners();
    }

    if (res != 'success') {
      showSnackBar(res, context);
    }
  }
  //  loginFucntios
  loginUsers(context) async {
    isloading = true;
    notifyListeners();
    String res = await AuthMethod().loginUser(
        email: emailController.text, password: passwordController.text);
    print(res);

    if (res == "success") {
      isloading = false;
      notifyListeners();
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
        );
      }
      emailController.clear();
      passwordController.clear();
    } else {
      showSnackBar(res, context);
    }
    isloading = false;
    notifyListeners();
  }
}
