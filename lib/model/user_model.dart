import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
   String email;
   String uid;
   String photoUrl;
   String username;
   String bio;
   List followers;
   List following;

  Users({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });
  Map<String, dynamic> tojson() => {
        'username': username,
        'uid': uid,
        'email': email,
        "photoUrl": photoUrl,
        'bio': bio,
        'followers': followers,
        'following': following
      };
  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data()as Map<String, dynamic>;

    return Users(
      username: snapshot["username"] ?? 'username',
      uid: snapshot["uid"] ?? 'uid',
      email: snapshot["email"] ?? 'email',
      photoUrl: snapshot["photoUrl"] ?? 'phontoUrl',
      bio: snapshot["bio"] ?? 'username',
      followers: snapshot["followers"] ?? 'followers',
      following: snapshot["following"] ?? 'following',
    );
  }
}
