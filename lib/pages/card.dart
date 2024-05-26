import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/userProvider.dart';
import '../widgets/primaryButton.dart';
import '../widgets/customTextFields.dart';

class PaymentCard extends StatelessWidget {
  final TextEditingController _creditCardController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _CVVController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(26, 10, 26, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Set Credit Card',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xFF1C1C1C),
                    ),
                  ),
                  Image.asset(
                    'assets/images/card.png', //
                    width: MediaQuery.of(context).size.width *
                        0.8, // Adjust the width as needed
                    height: MediaQuery.of(context).size.height *
                        0.3, // Adjust the height as neededْ
                    fit: BoxFit.contain, // Adjust the fit as needed
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xFF1C1C1C),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BigTextField(
                    fieldName: 'Credit Card Number',
                    hintText: '3829 4820 4629 5025',
                    isPassword: false,
                    controller: _creditCardController,
                    isValid: (value) {
                      if (RegExp(r'\b(?:\d[ -]*?){13,16}\b')
                              .matchAsPrefix(value.toString()) ==
                          null) {
                        return false;
                      }
                      return true;
                    },
                  ),
                  const SizedBox(height: 20),
                  BigTextField(
                    fieldName: 'Exp Date',
                    hintText: '09/25',
                    isPassword: false,
                    controller: _expiryDateController,
                    isValid: (value) {
                      if (RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$')
                              .matchAsPrefix(value.toString()) ==
                          null) {
                        return false;
                      }
                      return true;
                    },
                  ),
                  const SizedBox(height: 20),
                  BigTextField(
                    fieldName: 'CVV',
                    hintText: '202',
                    isPassword: false,
                    controller: _CVVController,
                    isValid: (value) {
                      if (RegExp(r'^\d{3,4}$')
                              .matchAsPrefix(value.toString()) ==
                          null) {
                        return false;
                      }
                      return true;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.goNamed('home');
                      // Define the action for the button
                      print("Cancel button pressed");
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: Container(
                      width: 160,
                      height: 63,
                      alignment: Alignment.center,
                      child: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF26356E),
                          fontSize: 20,
                          fontFamily: 'Istok Web',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        var userId = user.uid;
                        print("userId 222 $userId");
                      } else {
                        print("Error: User is not authenticated.");
                        // Handle the unauthenticated state appropriately, e.g., by redirecting to a login page
                      }
                      var cardNumber = _creditCardController.text;
                      var expiryDate = _expiryDateController.text;
                      var cvv = _CVVController.text;
                      // Define the action for the button
                      // show a popup that the card has been added
                      showDialog(
                        context: context,
                        builder: (BuildContext _context) {
                          return AlertDialog(
                            title: Text("Payment successful!"),
                            content: Text("Your Payment has been successful"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  userProvider.updateUserProfile("cart", []);
                                  Navigator.of(_context).pop();
                                  context.push('/');
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF26356E)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: Container(
                      width: 160,
                      height: 63,
                      alignment: Alignment.center,
                      child: Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Istok Web',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
