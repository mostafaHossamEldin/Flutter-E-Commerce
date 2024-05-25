import 'package:flutter/material.dart';

class AAProvider extends ChangeNotifier {
  // aaProvider.login(user.uid, user.email, user.displayName,
  //     user.photoURL, user.refreshToken);
  bool _isLoggedIn = false;
  String _uid = '';
  String? _email = '';
  String? _password = '';
  String? _displayName = '';
  String? _photoURL = '';
  String? _refreshToken = '';

  bool get isLoggedIn => _isLoggedIn;
  String get uid => _uid;
  String? get email => _email;
  String? get password => _password;
  String? get displayName => _displayName;
  String? get photoURL => _photoURL;
  String? get refreshToken => _refreshToken;

  void login(String uid, String? email, String? displayName, String? photoURL,
      String? refreshToken) {
    _uid = uid;
    _email = email;
    _displayName = displayName;
    _photoURL = photoURL;
    _refreshToken = refreshToken;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _uid = '';
    _email = '';
    _displayName = '';
    _photoURL = '';
    _refreshToken = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}
