import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'widgets/navBarButtom.dart';

import 'package:provider/provider.dart';
import 'providers/routesProvider.dart';
import 'providers/userProvider.dart';
import './providers/product_provider.dart';

import './widgets/drawer.dart';

// ...
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:travelgear/providers/vendor_product_provider.dart';
import 'providers/cart_provider.dart';

Future<void> main() async {
  final goRouterProvider = MyGoRouter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.requestPermission();

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => goRouterProvider),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => VendorProductProvider()),
    ],
    child: MyApp(),
  ));
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends HookWidget {
  Widget build(BuildContext context) {
    void _handleMessage(RemoteMessage message) {
      if (message.data['type'] == 'chat') {
        Navigator.pushNamed(
          context,
          '/chat',
          arguments: ChatArguments(message),
        );
      }
    }

    @override
    Future<void> setupInteractedMessage() async {
      // Get any messages which caused the application to open from
      // a terminated state.
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      // If the message also contains a data property with a "type" of "chat",
      // navigate to a chat screen
      if (initialMessage != null) {
        _handleMessage(initialMessage);
      }

      useEffect(() {
        setupInteractedMessage();
      }, []);

      // Also handle any interaction when the app is in the background via a
      // Stream listener
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    }

    final routeProvider = Provider.of<MyGoRouter>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Gear',
      home: Scaffold(
        drawer: CustomDrawer(),
        appBar: routeProvider.currentRoute != "/login" &&
                routeProvider.currentRoute != "/signup"
            ? PreferredSize(
                preferredSize: const Size.fromHeight(120),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                  color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: (userProvider.user.isLoggedIn &&
                              routeProvider.currentRoute != '/profile')
                          ? [
                              Builder(
                                builder: (context) {
                                  return IconButton(
                                    iconSize: 45,
                                    color: Colors.black,
                                    icon:
                                        const Icon(CupertinoIcons.list_bullet),
                                    onPressed: () =>
                                        Scaffold.of(context).openDrawer(),
                                  );
                                },
                              ),
                              IconButton(
                                iconSize: 45,
                                color: Colors.black,
                                icon:
                                    const Icon(CupertinoIcons.profile_circled),
                                onPressed: () {
                                  routeProvider.getRouter.push('/profile');
                                },
                              ),
                            ]
                          : [
                              Builder(
                                builder: (context) {
                                  return IconButton(
                                    iconSize: 45,
                                    color: Colors.black,
                                    icon:
                                        const Icon(CupertinoIcons.list_bullet),
                                    onPressed: () =>
                                        Scaffold.of(context).openDrawer(),
                                  );
                                },
                              ),
                            ]),
                ),
              )
            : null,
        body: Column(
          children: [
            Expanded(child: MyApp1()),
            CustomNavBar(),
          ],
        ),
      ),
    );
  }
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Provider.of<MyGoRouter>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router.getRouter,
      title: "Travel Gear",
    );
  }
}
