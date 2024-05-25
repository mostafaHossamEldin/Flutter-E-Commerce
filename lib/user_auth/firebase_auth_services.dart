import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    }
    catch (e) {
      print("Some error occured while signing in: $e");
    }
    return null;
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    }
    catch (e) {
      print("Some error occured while signing up: $e");
    }
    return null;
  }

   Future<String?> getToken(User user) async {
    try {
      String? token = await user.getIdToken();
      return token;
    } catch (e) {
      print("Some error occurred while getting the token: $e");
    }
    return null;
  }
}
