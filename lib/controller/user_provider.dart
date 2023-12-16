import 'package:flutter/widgets.dart';
import 'package:instanet/model/user_model.dart';
import 'package:instanet/services/auth_mehods.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  final AuthMethod _authMethods = AuthMethod();

  Users get getUser => _user!;

  UserProvider() {
    refreshUser();
  }
 

  Future<void> refreshUser() async {
    Users user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
