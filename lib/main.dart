import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_final/pages/login.dart';
import 'package:project_final/pages/signUp.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      initialLocation: '/signup', // Set initial route to login page
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
      ],
    );
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Travel Gear',
       
    );
  }
}