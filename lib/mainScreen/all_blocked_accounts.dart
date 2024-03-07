import 'package:flutter/material.dart';
import 'package:para_web_admin_portal/Drivers/all_blocked_drivers_screen.dart';
import 'package:para_web_admin_portal/Users/all_blocked_users_screen.dart';




class AllBlockedAccounts extends StatefulWidget
{
  const AllBlockedAccounts({super.key});

  @override
  State<AllBlockedAccounts> createState() => _AllBlockedAccountsState();
}

class _AllBlockedAccountsState extends State<AllBlockedAccounts> {
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
              AllBlockedUsersScreen(),
              AllBlockedDriversScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
