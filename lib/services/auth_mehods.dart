import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instanet/model/user_model.dart';
import 'package:instanet/helpers/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firetsore = FirebaseFirestore.instance;
   

   Future<Users> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firetsore.collection('user').doc(currentUser.uid).get();

    return Users.fromSnap(documentSnapshot);
  }

  Future<String> singUpuser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'some error occerred';
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty||
           file != null
          ) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);
          
        Users user=Users(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firetsore.collection('user').doc(cred.user!.uid).set(user.tojson());
        res = "success";
      }
    }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // login to user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = "please enter all the fields";
      } 
    } 
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // singout
   Future<void> signOut() async {
    await _auth.signOut();
  }
}
