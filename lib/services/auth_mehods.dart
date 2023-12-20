import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instanet/helpers/image.dart';
import 'package:instanet/model/user_model.dart';
import 'package:instanet/helpers/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firetsore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<Users> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firetsore.collection('user').doc(currentUser.uid).get();

    return Users.fromSnap(documentSnapshot);
  }

  // googleauth------------

  Future<String> signInWithGoogle() async {
    String res = 'no be stated';
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('tttttttttttttttttttttttttttttttttttttttttttttttttttttttttt');
      //  set the Users to firebase
      Users user = Users(
        username: googleUser!.displayName!,
        uid: FirebaseAuth.instance.currentUser!.uid,
        photoUrl: googleUser.photoUrl!,
        email: googleUser.email,
        bio: 'Using Intagram',
        followers: [],
        following: [],
      );

      await _firetsore
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.tojson());
      res = 'success';
      print('ppppppppppppppppppppppppppppppppppppppppppppppppppppppppp');
      return res;
    } catch (e) {
      print(e);
      res = 'worng on $e';
      return res;
    }
  }

  Future<String> singUpuser({
    required String email,
    required String password,
    required String username,
    required String bio,
    dynamic file,
  }) async {
    String res = 'some error occerred';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file!.isEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl;
        print(cred.user!.uid);
        if (file == defaultProfile) {
          photoUrl = defaultProfile;
        } else {
          photoUrl = await StorageMethods()
              .uploadImageToStorage("profilePics", file, false);
        }

        print(photoUrl);
        Users user = Users(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firetsore
            .collection('user')
            .doc(cred.user!.uid)
            .set(user.tojson());
        res = "success";
      }
    } catch (err) {
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
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // singout
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    // await _auth.signOut();
  }
}
