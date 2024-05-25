import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/userProvider.dart';
import '../user_auth/firebase_auth_services.dart';
import '../widgets/editButton.dart';
import '../widgets/primaryButton.dart';

class UserProfile extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
      child: Column(
        children: [
          Center(
            child: Image.asset('assets/images/defaultPFP.jpg',
                height: 130, width: 130),
          ),
          CustomEditButton(
            size: 40,
            onSave: () {},
            onEdit: () {},
          ),
          const Text('Name:'),
          const Text('Email:'),
          const Text('Phone Number:'),
          const Text('Address:'),
          const Text('City:'),
          const Text('Country:'),
          const Text('Postal Code:'),
          CustomPrimaryButton(
            text: "Logout",
            height: 50,
            width: double.infinity,
            onPressed: () async{
              await userProvider.logoutUser();
              context.goNamed('login');
            },
// icon: Icon(Icons.logout_rounded)),
          ),
        ],
      ),
    );
  }
}
