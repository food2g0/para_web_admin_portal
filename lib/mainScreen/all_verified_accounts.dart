import 'package:flutter/material.dart';
import 'package:para_web_admin_portal/Drivers/all_verified_drivers_screen.dart';
import 'package:para_web_admin_portal/Users/all_verified_users_screen.dart';




class AllVerifiedAccounts extends StatefulWidget
{
  const AllVerifiedAccounts({super.key});

  @override
  State<AllVerifiedAccounts> createState() => _AllVerifiedAccountsState();
}

class _AllVerifiedAccountsState extends State<AllVerifiedAccounts> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const TabBar(
          tabs: [
            Tab(
              text: "Commuters",
            ),
            Tab(
              text: "Drivers",
            ),
          ],
          indicatorColor: Colors.black,
          indicatorWeight: 6,
          labelColor: Colors.black,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold
          ),
          unselectedLabelColor: Colors.black54,
        ),
        body: Container(
          child: TabBarView(
            children: [
              AllVerifiedUsersScreen(),
              AllVerifiedDriversScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
