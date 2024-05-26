import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/signUp.dart';
import '../pages/view_all_page.dart';
import '../pages/userProfile.dart';
import '../pages/error.dart';
import '../pages/product.dart';
import '../pages/vendor_product_details.dart';
import '../pages/vendorLocations.dart';
import '../pages/vendorProducts.dart';
import '../pages/card.dart';
import '../pages/cart.dart';

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
          builder: (context, state) => UserCart(),
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
              return VendorProductDetailPage(
                productId: productId,
              );
            }
          },
        ),
        GoRoute(
          path: '/vendor-product',
          builder: (context, state) {
            return VendorProductDetailPage(productId: null);
          },
        ),
        GoRoute(
          path: '/vendor-products',
          builder: (context, state) {
            return VendorProducts();
          },
        ),
        GoRoute(
          path: '/vendor-locations',
          builder: (context, state) {
            return VendorLocations();
          },
        ),
        GoRoute(
          name: "payment",
          path: '/payment',
          builder: (context, state) {
            return PaymentCard();
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
      redirect: (context, state) {
        print("state.matchedLocation " + state.matchedLocation);
        updateRoute(state.matchedLocation);
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
