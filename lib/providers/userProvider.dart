import 'package:flutter/material.dart';
import '../Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../user_auth/firebase_auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  Userdb _user = Userdb(
    uid: '',
    email: '',
    displayName: '',
    isVendor: false,
    cart: {},
    isLoggedIn: false,
    companyName: '',
    gender: 0,
    profilePicture: Image.asset('assets/images/profile.png'),
    favorites: [],
    addresses: [],
  );

  Userdb get user => _user;

  Future<bool> signupUser(
      email, password, username, isVendor, companyName) async {
    var user = await _auth.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': username,
        'email': email,
        'isVendor': isVendor,
        'companyName': isVendor ? companyName : '',
      });
      _user = Userdb(
        uid: user.uid,
        email: email,
        displayName: username,
        isVendor: isVendor,
        cart: {},
        isLoggedIn: true,
        companyName: companyName,
        profilePicture: Image.asset('assets/images/profile.png'),
        gender: 0,
        favorites: [],
        addresses: [],
      );
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<bool> loginUser(email, password) async {
    var user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      _user = Userdb(
        isLoggedIn: true,
        uid: user.uid,
        email: email,
        displayName: userData['username'] ?? '',
        isVendor: userData['isVendor'] ?? false,
        cart: userData['cart'] ?? {},
        companyName: userData['companyName'] ?? '',
        gender: userData['gender'] ?? 0,
        profilePicture: userData['profilePicture'] ?? '',
        favorites: userData['favorites'] ?? [],
        addresses: userData['addresses'] ?? [],
      );
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
}
