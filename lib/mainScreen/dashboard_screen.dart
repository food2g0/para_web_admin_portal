import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:para_web_admin_portal/authentications/login_screen.dart';
import 'package:para_web_admin_portal/tabPages/home_tab.dart';
import 'package:para_web_admin_portal/tabPages/rating_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int _selectedIndex = 0;
  bool isExtended = false;

  @override
  void initState() {
    super.initState();


    _selectedIndex = 0; // Initialize _selectedIndex
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.black87,
            ],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1, 0),
            stops: [0, 1],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      title: const Text(
        "Para Admin Web Portal",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 3,
          fontFamily: "Anta"
        ),
      ),
      centerTitle: true,
    ),
    body: Row(
      children: [
        NavigationRail(
          backgroundColor: Colors.black,
          selectedIndex: _selectedIndex,
          extended: isExtended,
          selectedIconTheme: const IconThemeData(color: Colors.white, size: 50),
          unselectedIconTheme: const IconThemeData(color: Colors.white54, size: 30),
          selectedLabelTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          unselectedLabelTextStyle: const TextStyle(color: Colors.white54),
          onDestinationSelected: (index) => setState(() => this._selectedIndex = index),
          leading: GestureDetector(
            onTap: () {
              setState(() {
                isExtended = !isExtended;
              });
            },
            child: Image.asset(
              "images/1.gif",
              width: 60,
              height: 60,
              fit: BoxFit.fitHeight,
            ),
          ),
          trailing: isExtended
              ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 15, right: 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Logout",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Anta"),
                  ),
                ],
              ),
            ),
          )
              : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20.0),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
            },
            child: const Icon(Icons.logout, color: Colors.white),
          ),
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text(
                  "Home",
              style: TextStyle(
                fontFamily: "Anta"
              ),
              ),
            ),

            NavigationRailDestination( // Add the new tab
              icon: Icon(Icons.star),
              label: Text("Ratings",
                style: TextStyle(
                    fontFamily: "Anta"
                ),),
            ),
          ],
        ),
        Expanded(child: buildPages()),
      ],
    ),
  );

  Widget buildPages() {
    switch (_selectedIndex) {
      case 0:
        return HomeTabPage();
      case 1: // Add handling for the new tab
        return RatingTabPage();
      default:
        return HomeTabPage();
    }
  }
}
