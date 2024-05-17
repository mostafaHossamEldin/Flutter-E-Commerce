import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectt2/pages/home.dart';

import 'pages/login.dart';
import 'pages/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...





Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      initialLocation: '/login', // Set initial route to login page
      routes: [
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => Login(),
        ),
        GoRoute(
          name: 'signup',
          path: '/signup',
          builder: (context, state) => SignUp(),
        ),
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => Home(),
        ),
      ],
    );
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Travel Gear',
       
    );
  }
}