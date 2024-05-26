import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../widgets/primaryButton.dart';
import '../widgets/customTextFields.dart';
import '../widgets/radio.dart';

import '../user_auth/firebase_auth_services.dart';

import 'package:provider/provider.dart';
import '../providers/userProvider.dart';

class SignUp extends HookWidget {
  // Field Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  var _isVendor = false;

  // @override
  // void dispose() {
  //   _usernameController.dispose();
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _confirmPasswordController.dispose();
  //   _companyNameController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final isVendor = useState(false);
    final isLoading = useState(false);
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(26, 33, 26, 0),
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
                      BigTextField(
                          fieldName: "Username",
                          hintText: "Jack Danial ",
                          isPassword: false,
                          controller: _usernameController,
                          isValid: (value) {
                            return value!.length > 3 && value.length < 20;
                          }),
                      const SizedBox(height: 40),
                      BigTextField(
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
                      BigTextField(
                          fieldName: "Password",
                          hintText: "1234qwer",
                          isPassword: true,
                          controller: _passwordController,
                          isValid: (value) {
                            return value!.length >= 8 && value.length < 20;
                          }),
                      const SizedBox(height: 40),
                      BigTextField(
                          fieldName: "Confirm Password",
                          hintText: "1234qwer",
                          isPassword: true,
                          controller: _confirmPasswordController,
                          isValid: (value) {
                            return value == _passwordController.text;
                          }),
                      const SizedBox(height: 40),
                      if (_isVendor)
                        BigTextField(
                            fieldName: "Company Name",
                            hintText: "El shazly",
                            isPassword: false,
                            controller: _companyNameController,
                            isValid: (p) {
                              return p!.length > 3 && p.length < 20;
                            }),
                      if (_isVendor) const SizedBox(height: 40),
                      CustomRadio(
                        text: "Signup us a Vendor",
                        defaultValue: false,
                        controller: (value) {
                          _isVendor = value;
                        },
                      ),
                      const SizedBox(height: 40),
                      CustomPrimaryButton(
                        text: "Sign Up",
                        height: 50,
                        width: double.infinity,
                        onPressed: () async {
                          isLoading.value = true;
                          var email = _emailController.text;
                          var password = _passwordController.text;

                          if (email.isEmpty ||
                              password.isEmpty ||
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .matchAsPrefix(email) ==
                                  null ||
                              password.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please fill all fields correctly'),
                              ),
                            );
                            isLoading.value = false;
                            return;
                          }
                          if (await _signUp(context, _isVendor)) {
                            context.go('/');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Some error occured while signing up'),
                              ),
                            );
                          }
                          isLoading.value = false;
                        },
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xFF747474),
                          ),
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: const TextStyle(
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

  Future<bool> _signUp(context, bool isVendor) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    var username = _usernameController.text;
    var email = _emailController.text;
    var password = _passwordController.text;
    var confirmPassword = _confirmPasswordController.text;
    if (password != confirmPassword) {
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
          ),
        );
        return false;
      }
    }
    try {
      print("objectobjectobjectobject");
      return await userProvider.signupUser(email, password, username, isVendor,
          isVendor ? _companyNameController.text : '');
    } catch (e) {
      print("objectobjectobjectobjectTTTTTTTTTT");
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
