import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/signUp.dart';

class MyGoRouter extends ChangeNotifier {
  late final GoRouter _goRouter;
  String _currentRoute = '/login';

  MyGoRouter() {
    _goRouter = GoRouter(
      initialLocation: _currentRoute,
      routes: [
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => Home(),
        ),
        GoRoute(
          name: 'cart',
          path: '/cart',
          builder: (context, state) => Home(),
        ),
        GoRoute(
          name: 'notifications',
          path: '/notifications',
          builder: (context, state) => Home(),
        ),
        GoRoute(
          name: 'profile',
          path: '/profile',
          builder: (context, state) => Home(),
        ),
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
      redirect: (context, state) {
        print("state.matchedLocation " + state.matchedLocation);
        updateRoute(state.matchedLocation);
        return null; // No redirection
      },
    );
  }

  GoRouter get getRouter => _goRouter;

  String get currentRoute => _currentRoute;

  void updateRoute(String newRoute) {
    if (_currentRoute != newRoute) {
      _currentRoute = newRoute;
      notifyListeners();
    }
  }
}
