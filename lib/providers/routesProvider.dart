import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/signUp.dart';
import '../pages/view_all_page.dart';
import '../pages/userProfile.dart';

class MyNavigatorObserver extends NavigatorObserver {
  final Function(String) onPop;

  MyNavigatorObserver(this.onPop);

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute != null) {
      onPop(previousRoute.settings.name ?? '');
    }
    super.didPop(route, previousRoute);
  }
}

class MyGoRouter extends ChangeNotifier {
  late final GoRouter _goRouter;
  String _currentRoute = '/login';

  MyGoRouter() {
    _goRouter = GoRouter(
      initialLocation: _currentRoute,
      routes: [
        GoRoute(
          name: "home",
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: "cart",
          path: '/cart',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: "notifications",
          path: '/notifications',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: "profile",
          path: '/profile',
          builder: (context, state) => UserProfile(),
        ),
        GoRoute(
          name: "login",
          path: '/login',
          builder: (context, state) => Login(),
        ),
        GoRoute(
          name: "signup",
          path: '/signup',
          builder: (context, state) => SignUp(),
        ),
        GoRoute(
          name: "view-all-orders",
          path: '/my-orders',
          builder: (context, state) => SignUp(),
        ),
        GoRoute(
          path: '/my-favorites',
          builder: (context, state) => SignUp(),
        ),
        GoRoute(
            path: '/view-all',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>;
              return ViewAllPage(
                products: extra['products'],
                title: extra['title'],
              );
            })
      ],
      redirect: (context, state) {
        print("state.matchedLocation " + state.matchedLocation);
        updateRoute(state.matchedLocation);
        return null; // No redirection
      },
      observers: [
        MyNavigatorObserver((previousRouteName) {
          print('Popped to: $previousRouteName');
          updateRoute(previousRouteName);
        }),
      ],
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
