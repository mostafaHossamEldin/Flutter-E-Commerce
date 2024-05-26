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
    gender: "Male",
    profilePicture: Image.asset('assets/images/profile.png'),
    favorites: [],
    addresses: [],
  );

  Userdb get user => _user;

  void set setUid(p) => _user.uid = p;
  void set setEmail(p) => _user.email = p;
  void set setDisplayName(p) => _user.displayName = p;
  void set setIsVendor(p) => _user.isVendor = p;
  void set setCart(p) => _user.cart = p;
  void set setIsLoggedIn(p) => _user.isLoggedIn = p;
  void set setCompanyName(p) => _user.companyName = p;
  void set setProfilePicture(p) => _user.profilePicture = p;
  void set setGender(p) => _user.gender = p;
  void set setFavorites(p) => _user.favorites = p;
  void set setAddresses(p) => _user.addresses = p;
  void set setAll(p) => _user = p;

  Future<bool> signupUser(
      email, password, username, isVendor, companyName) async {
    print("Email: $email, Password: $password, Username: $username");
    var user = await _auth.signUpWithEmailAndPassword(email, password);
    print("User: $user");
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
        gender: "Male",
        favorites: [],
        addresses: [],
      );
      print("&salKheir");
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

      print("Hey papa");
      print(userData.data());
      final Map<String, dynamic> data = userData.data() as Map<String, dynamic>;

      _user = Userdb(
        isLoggedIn: true,
        uid: user.uid,
        email: email,
        displayName: data['username'] ?? '',
        isVendor: data['isVendor'] ?? false,
        cart: data.containsKey('cart') ? data['cart'] : {},
        companyName: data['companyName'] ?? '',
        gender: data.containsKey('gender') ? data['gender'] : 0,
        profilePicture: data.containsKey('profilePicture')
            ? data['profilePicture']
            : Image.asset('assets/images/defaultPFP.jpg'),
        favorites: data.containsKey('favorites') ? data['favorites'] : [],
        addresses: data.containsKey('addresses') ? data['addresses'] : [],
      );

      print("Dont worry papa");
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<void> updateUserProfile(String fieldName, value) async {
    await FirebaseFirestore.instance.collection('users').doc(_user.uid).update({
      fieldName: value,
    });
    switch (fieldName) {
      case 'uid':
        _user.uid = value;
        break;
      case 'email':
        _user.email = value;
        break;
      case 'displayName':
        _user.displayName = value;
        break;
      case 'isVendor':
        _user.isVendor = value;
        break;
      case 'cart':
        _user.cart = value;
        break;
      case 'isLoggedIn':
        _user.isLoggedIn = value;
        break;
      case 'companyName':
        _user.companyName = value;
        break;
      case 'profilePicture':
        _user.profilePicture = value;
        break;
      case 'gender':
        _user.gender = value;
        break;
      case 'favorites':
        _user.favorites = value;
        break;
      case 'addresses':
        _user.addresses = value;
        break;
    }
  }
}
