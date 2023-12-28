import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instanet/model/user_model.dart';
import 'package:instanet/services/auth_mehods.dart';
import 'package:instanet/view/bottom_bar/mobile_screen_layout.dart';
import 'package:instanet/view/login_page/widgets/details_page.dart';
import 'package:instanet/view/widgets/show_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileController extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  bool _isLoading = false;
  bool get isloading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  Users? _usermodel;
  Users get usermode => _usermodel!;

  final TextEditingController numbercontroller = TextEditingController();
  Country SelectedCountry = Country(
      phoneCode: '91',
      countryCode: 'IN',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "india",
      example: "india",
      displayName: "india",
      displayNameNoCountryCode: "IN",
      e164Key: '');

  selectChanges(value) {
    SelectedCountry = value;
    notifyListeners();
  }

  // login with phonenumber
  loginWithPhone(context, phoneNumber) {
    AuthMethod().loginWithPhoneNumber(
        context, "+${SelectedCountry.phoneCode}$phoneNumber");
    notifyListeners();
  }

  // verfyotpconnections 1111111!
  void verifyOtp(
    BuildContext context,
    String userOtp,
    String verifcationId,
  ) {
    verifyOtps(
        context: context,
        verifcationId: verifcationId,
        userOtp: userOtp,
        onSuccess: () {
          checkExithingUser().then((value) async {
            if (value == true) {
              print(
                  'user exiting the app  yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
              getDataFromFirebase().then((value) => saveUserDataToSP().then(
                  (value) => setSignIn().then((value) =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MobileScreenLayout()),
                          (route) => false))));
            } else {
              print(
                  'user exiting the app  oooooooooooooooooooooooooooooooooooooooooooooooo');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInformationScreen()),
                  (route) => false);
            }
          });
        });
  }

  //  verifyOtp @@222
  verifyOtps(
      {required BuildContext context,
      required String verifcationId,
      required String userOtp,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verifcationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message.toString(), context);
      _isLoading = false;
      notifyListeners();
    }
  }

  // database opertaion user exiting or not
  Future<bool> checkExithingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection('user').doc(_uid).get();
    if (snapshot.exists) {
      print("user exits");
      return true;
    } else {
      print('New user');
      return false;
    }
  }

// store to the firebsedatbase
 savaUserDataToFirebase(
      {required BuildContext context,
      required Users usermodel,
      required File profilePic,
      required Function onSuccess
      }) async {
    print('1111111111111111111111111111111111111111111111111pppppp');
    // _isLoading = true;
    print(uid ??'afkil ');
    // print(profilePic ??'kkkkqq');
    print(usermodel.email ??'kkkkaa');
    print(usermodel.bio ??'kkkkww');
    print(usermodel.username ??'kkkkdd');
    // print(u);
    print(usermodel.bio.toString()??'dkfsl');
    _isLoading = true;
    notifyListeners();
    try {
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        usermodel.photoUrl = value;

        usermodel.uid = _firebaseAuth.currentUser!.uid;
      });
      _usermodel = usermodel;

      //  UPLOADING TO DATABASE
      await _firebaseFirestore
          .collection("user")
          .doc(_usermodel!.uid)
          .set(usermodel.tojson())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar( e.message.toString(),context,);
      _isLoading = false;
      notifyListeners();
    }
  }

  // get data from the firebase;
  Future getDataFromFirebase() async {
    await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _usermodel = Users(
          email: snapshot['email'],
          uid: snapshot['uid'],
          photoUrl: snapshot['photoUrl'],
          username: snapshot['username'],
          bio: snapshot['bio'],
          followers: snapshot['followers'],
          following: snapshot['following']);
      _uid = usermode.uid;
    });
  }

  // upload the data to SharedPreferences
 Future saveUserDataToSP() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString("user_model", jsonEncode(usermode.tojson()));
  }
  // set to  the userset
 Future setSignIn() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // convet to the url type
  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
