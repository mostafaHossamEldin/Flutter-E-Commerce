import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'widgets/navBarButtom.dart';
import 'widgets/navBarTop.dart';

import 'package:provider/provider.dart';
import 'providers/routesProvider.dart';
import 'providers/authProvider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './providers/product_provider.dart';

import './widgets/drawer.dart';

// ...

Future<void> main() async {
  final goRouterProvider = MyGoRouter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => goRouterProvider),
      ChangeNotifierProvider(create: (_) => AAProvider()),
      ChangeNotifierProvider(create: (_) => ProductsProvider()),
    ],
    child: MyApp(),
  ));
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Gear',
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: IconButton(
                iconSize: 45,
                icon: const Icon(CupertinoIcons.list_bullet),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: IconButton(
                iconSize: 45,
                icon: const Icon(CupertinoIcons.profile_circled),
                onPressed: () {},
              ),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(38, 53, 110, 1),
                  Color.fromRGBO(0, 0, 0, 1),
                ],
              ),
            ),
          ),
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(child: CustomTopNavigator()),
              ],
            ),
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
