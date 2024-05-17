import 'package:flutter/material.dart';
import 'dart:ui';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../user_auth/firebase_auth_services.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    final FirebaseAuthServices _auth = FirebaseAuthServices();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child:
         Container(
          padding: EdgeInsets.fromLTRB(24, 36, 0, 0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: 666,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 40),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 295,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                      'D:\VSCode\Flutter Projects\projectt2\assets\list.png',
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(19),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      '/assets/images/ellipse_1.png',
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(1, 0, 1, 19),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0.2, 0, 0.2, 0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Welcome,',
                                  style: GoogleFonts.getFont(
                                    'Istok Web',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32,
                                    color: Color(0xFF1C1C1C),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Explore the Travel Gear',
                              style: GoogleFonts.getFont(
                                'Istok Web',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Color(0xFF747474),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(2, 0, 2, 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 11, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: SizedBox(
                                  width: 271,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                  'assets/images/search.png',
                                                ),
                                              ),
                                            ),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 3.5, 0, 3.5),
                                          child: Text(
                                            'Search...',
                                            style: GoogleFonts.getFont(
                                              'Istok Web',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Color(0xFF808080),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF26356E),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Container(
                                width: 50,
                                height: 50,
                                padding: EdgeInsets.fromLTRB(7, 8, 8, 7),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                        'assets/images/advanced_search.png',
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(1.4, 0, 1.4, 71),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Categories',
                          style: GoogleFonts.getFont(
                            'Istok Web',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 1, 11.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(1.1, 0, 1.1, 1.5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 323.8,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 17.5, 0),
                                      child: SizedBox(
                                        width: 244.6,
                                        child: Text(
                                          'Top Rated',
                                          style: GoogleFonts.getFont(
                                            'Istok Web',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                            color: Color(0xFF1C1C1C),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 1, 0, 11),
                                      child: Text(
                                        'View All',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Color(0xFF757575),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              SizedBox(
                                width: 325,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                      child: SizedBox(
                                        width: 155,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 50, 50, 50),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                    'assets/images/image.png',
                                                  ),
                                                ),
                                              ),
                                              child: Container(
                                                width: 155,
                                                height: 155,
                                              ),
                                            ),
                                            Text(
                                              'Product Name',
                                              style: GoogleFonts.getFont(
                                                'Istok Web',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Color(0xFF1C1C1C),
                                              ),
                                            ),
                                            Text(
                                              'Category',
                                              style: GoogleFonts.getFont(
                                                'Istok Web',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: Color(0xFF1C1C1C),
                                              ),
                                            ),
                                            Text(
                                              '\$399.99',
                                              style: GoogleFonts.getFont(
                                                'Istok Web',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                                color: Color(0xFF1C1C1C),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 155,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromARGB(255, 50, 50, 50),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                  'assets/images/image.png',
                                                ),
                                              ),
                                            ),
                                            child: Container(
                                              width: 155,
                                              height: 155,
                                            ),
                                          ),
                                          Text(
                                            'Product Name',
                                            style: GoogleFonts.getFont(
                                              'Istok Web',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Color(0xFF1C1C1C),
                                            ),
                                          ),
                                          Text(
                                            'Category',
                                            style: GoogleFonts.getFont(
                                              'Istok Web',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Color(0xFF1C1C1C),
                                            ),
                                          ),
                                          Text(
                                            '\$399.99',
                                            style: GoogleFonts.getFont(
                                              'Istok Web',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                              color: Color(0xFF1C1C1C),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 170,
                                bottom: 0,
                                child: SizedBox(
                                  width: 155,
                                  height: 216,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 50, 50, 50),
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              'assets/images/image.png',
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 155,
                                          height: 155,
                                        ),
                                      ),
                                      Text(
                                        'Product Name',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                      Text(
                                        'Category',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                      Text(
                                        '\$399.99',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: SizedBox(
                                  width: 155,
                                  height: 216,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 50, 50, 50),
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              'assets/images/image.png',
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 155,
                                          height: 155,
                                        ),
                                      ),
                                      Text(
                                        'Product Name',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                      Text(
                                        'Category',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                      Text(
                                        '\$399.99',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(1.4, 0, 1.4, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 323.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 1, 17.5, 0),
                                      child: SizedBox(
                                        width: 244.3,
                                        child: Text(
                                          'Discounts',
                                          style: GoogleFonts.getFont(
                                            'Istok Web',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                            color: Color(0xFF1C1C1C),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                                      child: Text(
                                        'View All',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Color(0xFF757575),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              SizedBox(
                                width: 325,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                      child: SizedBox(
                                        width: 155,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 50, 50, 50),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                    'assets/images/image.png',
                                                  ),
                                                ),
                                              ),
                                              child: Container(
                                                width: 155,
                                                height: 155,
                                              ),
                                            ),
                                            Text(
                                              'Product Name',
                                              style: GoogleFonts.getFont(
                                                'Istok Web',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Color(0xFF1C1C1C),
                                              ),
                                            ),
                                            Text(
                                              'Category',
                                              style: GoogleFonts.getFont(
                                                'Istok Web',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: Color(0xFF1C1C1C),
                                              ),
                                            ),
                                            Text(
                                              '\$399.99',
                                              style: GoogleFonts.getFont(
                                                'Istok Web',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                                color: Color(0xFF1C1C1C),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 155,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromARGB(255, 50, 50, 50),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                  'assets/images/image.png',
                                                ),
                                              ),
                                            ),
                                            child: Container(
                                              width: 155,
                                              height: 155,
                                            ),
                                          ),
                                          Text(
                                            'Product Name',
                                            style: GoogleFonts.getFont(
                                              'Istok Web',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Color(0xFF1C1C1C),
                                            ),
                                          ),
                                          Text(
                                            'Category',
                                            style: GoogleFonts.getFont(
                                              'Istok Web',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Color(0xFF1C1C1C),
                                            ),
                                          ),
                                          Text(
                                            '\$399.99',
                                            style: GoogleFonts.getFont(
                                              'Istok Web',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                              color: Color(0xFF1C1C1C),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 170,
                                bottom: 0,
                                child: SizedBox(
                                  width: 155,
                                  height: 216,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 50, 50, 50),
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              'assets/images/image.png',
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 155,
                                          height: 155,
                                        ),
                                      ),
                                      Text(
                                        'Product Name',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                      Text(
                                        'Category',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                      Text(
                                        '\$399.99',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: SizedBox(
                                  width: 155,
                                  height: 216,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 50, 50, 50),
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              'assets/images/image.png',
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 155,
                                          height: 155,
                                        ),
                                      ),
                                      Text(
                                        'Product Name',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                      Text(
                                        'Category',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                      Text(
                                        '\$399.99',
                                        style: GoogleFonts.getFont(
                                          'Istok Web',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: -24,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, -2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: 375,
                    height: 63,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF26356E),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                      'assets/images/home_1.png',
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    'assets/images/shopping_cart_1.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    'assets/images/notification_1.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    'assets/images/customer.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 2,
                right: 29,
                top: 276,
                child: SizedBox(
                  width: 320,
                  height: 32,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF26356E)),
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFFFFFFFF),
                                ),
                                child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(12.9, 3.5, 12.9, 3.5),
                                  child: Text(
                                    'Suitcases',
                                    style: GoogleFonts.getFont(
                                      'Istok Web',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Color(0xFF26356E),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF26356E)),
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFFFFFFFF),
                                ),
                                child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(8.7, 3.5, 8.7, 3.5),
                                  child: Text(
                                    'Carry bags',
                                    style: GoogleFonts.getFont(
                                      'Istok Web',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Color(0xFF26356E),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF26356E)),
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFFFFFFFF),
                                ),
                                child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(7.5, 3.5, 7.5, 3.5),
                                  child: Text(
                                    'Sleep pads',
                                    style: GoogleFonts.getFont(
                                      'Istok Web',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Color(0xFF26356E),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                                          ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
             label: 'Logout',
          
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),

    );
  }
}