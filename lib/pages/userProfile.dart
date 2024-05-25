import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../providers/userProvider.dart';
import '../widgets/editButton.dart';

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
        ],
      ),
    );
  }
}
