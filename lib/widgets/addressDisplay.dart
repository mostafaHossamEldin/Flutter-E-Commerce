import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:travelgear/Models/Address.dart';
import '../widgets/editButton.dart';

class AddressDisplay extends HookWidget {
  final String streetAddress1;
  final String streetAddress2;
  final String city;
  final String state;
  final String phoneNumber;
  final String zipCode;
  final String country;
  final void Function(Address) onSave;

  AddressDisplay({
    required this.streetAddress1,
    required this.streetAddress2,
    required this.city,
    required this.state,
    required this.phoneNumber,
    required this.zipCode,
    required this.country,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final isEditing = useState(false);
    final streetAddress1Controller =
        useTextEditingController(text: streetAddress1);
    final streetAddress2Controller =
        useTextEditingController(text: streetAddress2);
    final cityController = useTextEditingController(text: city);
    final stateController = useTextEditingController(text: state);
    final phoneNumberController = useTextEditingController(text: phoneNumber);
    final zipCodeController = useTextEditingController(text: zipCode);
    final countryController = useTextEditingController(text: country);

    return Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          // drop shadow
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      const Text(
                        "Street Address 1: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C1C1C),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Container(
                          width: 130,
                          child: TextField(
                            enabled: isEditing.value,
                            controller: streetAddress1Controller,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C1C1C),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        child: const Text(
                          "Street Address 2: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        child: TextField(
                          enabled: isEditing.value,
                          controller: streetAddress2Controller,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        child: const Text(
                          "City: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        child: TextField(
                          enabled: isEditing.value,
                          controller: cityController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        child: const Text(
                          "State: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        child: TextField(
                          enabled: isEditing.value,
                          controller: stateController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        child: const Text(
                          "Phone Number: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        child: TextField(
                          enabled: isEditing.value,
                          controller: phoneNumberController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        child: const Text(
                          "Zip Code: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        child: TextField(
                          enabled: isEditing.value,
                          controller: zipCodeController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        child: const Text(
                          "Country: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        child: TextField(
                          enabled: isEditing.value,
                          controller: countryController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 230, 0, 0),
              child: CustomEditButton(
                  onSave: () {
                    onSave(Address(
                      streetAddress1: streetAddress1Controller.text,
                      streetAddress2: streetAddress2Controller.text,
                      city: cityController.text,
                      state: stateController.text,
                      phoneNumber: phoneNumberController.text,
                      zipCode: zipCodeController.text,
                      country: countryController.text,
                    ));
                    isEditing.value = false;
                  },
                  onEdit: () {
                    isEditing.value = true;
                  },
                  size: 35),
            )
          ],
        ));
  }
}
