import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:travelgear/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:travelgear/widgets/primaryButton.dart';
import '../widgets/addressDisplay.dart';
import '../widgets/customTextFields.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import '../Models/Address.dart';

class VendorLocations extends HookWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Vendor Locations",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                      children: (userProvider.user.addresses.isEmpty)
                          ? ([
                              Text(
                                "No addresses found",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomPrimaryButton2(
                                  text: "Add Location",
                                  onPressed: () {
                                    userProvider
                                        .updateUserProfile("addresses", [
                                      ...userProvider.user.addresses,
                                      Address(
                                        streetAddress1: "",
                                        streetAddress2: "",
                                        city: "",
                                        state: "",
                                        phoneNumber: "",
                                        zipCode: "",
                                        country: "",
                                      )
                                    ]);
                                  },
                                  width: double.infinity,
                                  height: 50,
                                  icon: Icon(
                                    size: 24,
                                    CupertinoIcons.add_circled_solid,
                                    color: Colors.white,
                                  )),
                            ])
                          : [
                              ...userProvider.user.addresses.map(
                                (address) {
                                  return Column(
                                    children: [
                                      AddressDisplay(
                                        streetAddress1: "",
                                        streetAddress2: "",
                                        city: "Cairo",
                                        state: "Cairo",
                                        phoneNumber: "123456789",
                                        zipCode: "12345",
                                        country: "Egypt",
                                        onSave: (address) {
                                          userProvider.updateUserProfile(
                                              "address", address);
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  );
                                },
                              ).toList() as List<Widget>,
                              SizedBox(
                                height: 20,
                              ),
                              CustomPrimaryButton2(
                                  text: "Add Location",
                                  onPressed: () {
                                    print([
                                      ...userProvider.user.addresses,
                                      Address(
                                        streetAddress1: "",
                                        streetAddress2: "",
                                        city: "",
                                        state: "",
                                        phoneNumber: "",
                                        zipCode: "",
                                        country: "",
                                      )
                                    ]);
                                    userProvider
                                        .updateUserProfile("addresses", [
                                      ...userProvider.user.addresses.map(
                                        (address) => address.toJson(),
                                      ),
                                      Address(
                                        streetAddress1: "",
                                        streetAddress2: "",
                                        city: "",
                                        state: "",
                                        phoneNumber: "",
                                        zipCode: "",
                                        country: "",
                                      ).toJson()
                                    ]);
                                  },
                                  width: double.infinity,
                                  height: 50,
                                  icon: Icon(
                                    size: 24,
                                    CupertinoIcons.add_circled_solid,
                                    color: Colors.white,
                                  )),
                            ]),
                )
              ],
            ),
          ),
        ));
  }
}
