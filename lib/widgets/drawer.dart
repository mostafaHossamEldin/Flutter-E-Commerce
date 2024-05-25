import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/routesProvider.dart';

class CustomDrawer extends StatelessWidget {
  // final Function(String) onNavigate;
  // final Function() onLogout;

  // CustomDrawer({
  //   required this.onNavigate,
  //   required this.onLogout,
  // });

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<MyGoRouter>(context);
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
                child: Builder(
                  builder: (context) {
                    return IconButton(
                      iconSize: 45,
                      color: Colors.black,
                      icon: const Icon(CupertinoIcons.list_bullet),
                      onPressed: () => Scaffold.of(context).closeDrawer(),
                    );
                  },
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 110,
              //drop shadow
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Row(children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 15, 20, 15),
                  child: Image.asset('assets/images/defaultPFP.jpg'),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('email@gmail.com')
                    ]),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      routeProvider.getRouter.push('/profile');
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    size: 25,
                                    CupertinoIcons.person_fill,
                                    color: Colors.white,
                                  ),
                                ),
                                // circle blue background
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(38, 53, 110, 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(CupertinoIcons.right_chevron),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {
                      routeProvider.getRouter.push('/my-orders');
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    size: 25,
                                    CupertinoIcons.bag_fill,
                                    color: Colors.white,
                                  ),
                                ),
                                // circle blue background
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(38, 53, 110, 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Orders',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(CupertinoIcons.right_chevron),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {
                      routeProvider.getRouter.push('/my-favorites');
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    size: 25,
                                    CupertinoIcons.heart_fill,
                                    color: Colors.white,
                                  ),
                                ),
                                // circle blue background
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(38, 53, 110, 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Favorites',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(CupertinoIcons.right_chevron),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {
                      routeProvider.getRouter.push('/notifications');
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    size: 25,
                                    CupertinoIcons.bell_fill,
                                    color: Colors.white,
                                  ),
                                ),
                                // circle blue background
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(38, 53, 110, 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(CupertinoIcons.right_chevron),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
