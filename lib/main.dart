import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:travelgear/pages/product.dart';

import 'firebase_options.dart';
import 'pages/login.dart';
import 'pages/signUp.dart';
import 'pages/home.dart';
import 'pages/view_all_page.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
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
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
            path: '/view-all',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>;
              return ViewAllPage(
                products: extra['products'],
                title: extra['title'],
              );
            }),
        // GoRoute(
        //   path: '/product/:id',
        //   builder: (context, state) {
        //     final productId = state.pathParameters['id'];
        //     return ProductDetailPage(productId: productId);
        //   },
        // ),
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        //ChangeNotifierProvider(create: (_) => VendorProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Travel Gear',
      ),
    );
  }
}
