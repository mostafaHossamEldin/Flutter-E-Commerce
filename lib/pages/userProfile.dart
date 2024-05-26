import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/userProvider.dart';
import '../user_auth/firebase_auth_services.dart';
import '../widgets/editButton.dart';
import '../widgets/customTextFields.dart';
import '../widgets/radio.dart';
import '../widgets/addressDisplay.dart';
import '../widgets/primaryButton.dart';
import '../widgets/optionsSection.dart';
import '../widgets/optionButton.dart';
import 'package:flutter/cupertino.dart';

class UserProfile extends HookWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset('assets/images/defaultPFP.jpg',
                          height: 130, width: 130),
                    ),
                  ),
                  Positioned(
                    right: 100,
                    top: 100,
                    child: Center(
                      child: CustomEditButton(
                        size: 35,
                        onSave: () {},
                        onEdit: () {},
                      ),
                    ),
                  )
                ],
              ),
              const Center(
                child: Text(
                  "Profile Picture",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              EditableTextField(
                  fieldName: "Name",
                  hintText: "john_doe",
                  initialText: userProvider.user.displayName,
                  isValid: (p) {
                    return true;
                  },
                  submitEdit: (p) {
                    userProvider.updateUserProfile("displayName", p);
                  }),
              SizedBox(height: 20),
              EditableTextField(
                  fieldName: "Email",
                  hintText: "john_doe@gmail.com",
                  initialText: userProvider.user.email,
                  isValid: (p) {
                    return true;
                  },
                  submitEdit: (p) {
                    userProvider.updateUserProfile("email", p);
                  }),
              SizedBox(height: 20),
              userProvider.user.isVendor
                  ? EditableTextField(
                      fieldName: "Company",
                      hintText: "El shazzly",
                      initialText: userProvider.user.displayName,
                      isValid: (p) {
                        return true;
                      },
                      submitEdit: (p) {
                        userProvider.updateUserProfile("displayName", p);
                      })
                  : SizedBox(),
              userProvider.user.isVendor ? SizedBox(height: 20) : SizedBox(),
              CustomRadioBig(
                text: "Gender",
                defaultValue: userProvider.user.gender ?? "Male",
                controller: (value) {
                  userProvider.updateUserProfile("gender", value);
                },
                option1: "Male",
                option2: "Female",
              ),
              SizedBox(height: 20),
              userProvider.user.isVendor
                  ? OptionsSection(options: [
                      OptionButton(
                        title: "Depot Locations",
                        onTap: () {
                          context.push('/vendor-locations');
                        },
                        icon: Icon(CupertinoIcons.location_fill),
                      ),
                      OptionButton(
                        title: "My Products",
                        onTap: () {
                          context.push('/vendor-products');
                        },
                        icon: Icon(CupertinoIcons.square_grid_2x2_fill),
                      ),
                      OptionButton(
                        title: "Add Product",
                        onTap: () {
                          context.push('/');
                        },
                        icon: Icon(CupertinoIcons.add_circled_solid),
                      ),
                    ])
                  : const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Delivery Address",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                          )),
                    ),
              SizedBox(height: 20),
              !userProvider.user.isVendor
                  ? AddressDisplay(
                      streetAddress1: "",
                      streetAddress2: "",
                      city: "Cairo",
                      state: "Cairo",
                      phoneNumber: "123456789",
                      zipCode: "12345",
                      country: "Egypt",
                      onSave: (address) {
                        userProvider.updateUserProfile("address", address);
                      },
                    )
                  : SizedBox(),
              SizedBox(height: 20),
              CustomPrimaryButton2(
                  text: "Logout",
                  height: 50,
                  width: double.infinity,
                  onPressed: () async {
                    await userProvider.logoutUser();
                    context.goNamed('login');
                  },
                  icon: Icon(
                    CupertinoIcons.square_arrow_left_fill,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
