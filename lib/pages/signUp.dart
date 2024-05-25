import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import '../widgets/primaryButton.dart';
import '../widgets/textfield.dart';

import '../user_auth/firebase_auth_services.dart';

class SignUp extends StatelessWidget {
  // Field Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(26, 33, 26, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Travel Gear',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            fontWeight: FontWeight.w400,
                            fontSize: 40,
                            height: 1.3,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                        Text(
                          'My Life My Gadget',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Signup!',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Color(0xFF1C1C1C),
                      ),
                    ),
                    Text(
                      'Become a part of our community!',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xFF747474),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                CustomTextfield(
                    fieldName: "Username",
                    hintText: "Jack Danial ",
                    isPassword: false,
                    controller: _usernameController,
                    isValid: (value) {
                      return value!.length > 3 && value.length < 20;
                    }),
                const SizedBox(height: 40),
                CustomTextfield(
                    fieldName: "Email",
                    hintText: "JackDanial@google.com",
                    isPassword: false,
                    controller: _emailController,
                    isValid: (value) {
                      return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .matchAsPrefix(value.toString()) !=
                          null;
                    }),
                const SizedBox(height: 40),
                CustomTextfield(
                    fieldName: "Password",
                    hintText: "1234qwer",
                    isPassword: true,
                    controller: _passwordController,
                    isValid: (value) {
                      return value!.length >= 8 && value.length < 20;
                    }),
                const SizedBox(height: 40),
                CustomTextfield(
                    fieldName: "Confirm Password",
                    hintText: "1234qwer",
                    isPassword: true,
                    controller: _confirmPasswordController,
                    isValid: (value) {
                      return value == _passwordController.text;
                    }),
                const SizedBox(height: 40),
                CustomPrimaryButton(
                  text: "Sign Up",
                  height: 50,
                  width: double.infinity,
                  onPressed: () async {
                    if (await _signUp(context)) {
                      context.goNamed('home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Some error occured while signing up'),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0xFF747474),
                    ),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          height: 1.3,
                          color: Color(0xFF3C99DD),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to login page
                            context.goNamed('login');
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _signUp(context) async {
    var username = _usernameController.text;
    var email = _emailController.text;
    var password = _passwordController.text;
    var confirmPassword = _confirmPasswordController.text;
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return false;
    }
    if (password != confirmPassword) {
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match'),
          ),
        );
        return false;
      }
    }
    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        print('User Successgully Created!');
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
        });
        return true;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Some error occured while signing up: $e'),
        ),
      );
      return false;
    }
    return false;
  }
}
