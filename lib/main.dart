import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:travelgear/pages/error.dart';
import 'package:travelgear/pages/product.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:travelgear/pages/vendor_product_details.dart';
import 'package:travelgear/providers/vendor_product_provider.dart';
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

  await FirebaseMessaging.instance.requestPermission();

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
        GoRoute(
          path: '/product/:id',
          builder: (context, state) {
            final productId = state.pathParameters['id'];
            print(productId); 
            if (productId == null) {
              return const ErrorPage(
                  message: 'Product ID is missing in the route');
            } else {
              return ProductDetailPage(productId: productId);
            }
          },
        ),
        GoRoute(
          path: '/vendor-product/:id',
          builder: (context, state) {
            final productId = state.pathParameters['id'];
             print(productId); 

            if (productId == null) {
              return const ErrorPage(
                  message: 'Product ID is missing in the route');
            } else {
              return VendorProductDetailPage(productId: productId);
            }
          },
        ),
        GoRoute(
          path: '/vendor-product',
          builder: (context, state) {
            return const VendorProductDetailPage(productId: null);
          },
        ),
        //  GoRoute(
        //       path: '/vendor-product/:id',
        //       builder: (context, state) => VendorProductDetailPage(),
        //       redirect: (context, state) async {
        //         final vendorProvider = Provider.of<VendorProductProvider>(context, listen: false);
        //         final isAuthenticated = await vendorProvider.isAuthenticated();
        //         if (!isAuthenticated) {
        //           return '/error/not_authenticated';
        //         }
        //         final isVendor = await vendorProvider.isVendor();
        //         if (!isVendor) {
        //           return '/error/not_authorised';
        //         }
        //         return null;
        //       },
        //     ),

        GoRoute(
          path: '/error/:message',
          builder: (context, state) {
            final message = state.pathParameters['message']!;
            return ErrorPage(message: message);
          },
        ),
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => VendorProductProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Travel Gear',
      ),
    );
  }
}
