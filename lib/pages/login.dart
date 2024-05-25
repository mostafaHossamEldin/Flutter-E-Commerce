import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:ui';

import 'package:go_router/go_router.dart';

import '../user_auth/firebase_auth_services.dart';
import '../widgets/textfield.dart';
import '../widgets/primaryButton.dart';
import '../providers/authProvider.dart';
import 'package:provider/provider.dart';

class Login extends HookWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    final aaProvider = Provider.of<AAProvider>(context);
    final isLoading = useState(false);
    return Scaffold(
      body: isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.fromLTRB(26, 33, 26, 0),
              child: SingleChildScrollView(
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
                          'Welcome!',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                        Text(
                          'please login or sign up to access more features',
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
                      fieldName: 'Email',
                      hintText: 'JackDanial@google.com',
                      isPassword: false,
                      controller: _emailController,
                      isValid: (value) {
                        if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .matchAsPrefix(value.toString()) ==
                            null) {
                          return false;
                        }
                        return true;
                      },
                    ),
                    const SizedBox(height: 40),
                    CustomTextfield(
                      fieldName: 'Password',
                      hintText: '1234qwer',
                      isPassword: true,
                      controller: _passwordController,
                      isValid: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return false;
                        }
                        return true;
                      },
                    ),
                    const SizedBox(height: 40),
                    CustomPrimaryButton(
                      text: "Login",
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
                            password.length < 8) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all fields'),
                            ),
                          );
                          isLoading.value = false;
                          return;
                        }
                        try {
                          User? user = await _auth.signInWithEmailAndPassword(
                              email, password);
                          if (user != null) {
                            print('User Logged In!');
                            aaProvider.login(
                                user.uid,
                                user.email,
                                user.displayName,
                                user.photoURL,
                                user.refreshToken);
                            // removing dialog
                            context.goNamed('home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('User not found'),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Some error occured while signing up: $e'),
                            ),
                          );
                        } finally {
                          isLoading.value = false;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xFF747474),
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  height: 1.3,
                                  color: Color(0xFF3C99DD),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to login page
                                    context.goNamed('signup');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
