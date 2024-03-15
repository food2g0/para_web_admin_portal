import 'package:flutter/material.dart';
import 'package:para_web_admin_portal/mainScreen/all_blocked_accounts.dart';
import 'package:para_web_admin_portal/mainScreen/all_verified_accounts.dart';
import 'package:para_web_admin_portal/registrationRequests/all_registration_requests.dart';




class HomeTabPage extends StatefulWidget
{
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const TabBar(
          tabs: [
            Tab(
              text: "Drivers Account" + "\n" + " for Registration",
            ),
            Tab(
              text: "Verified" + "\n" + "Accounts",
            ),
            Tab(
              text: "Blocked"+ "\n" + "Accounts",
            ),
          ],
          indicatorColor: Colors.black,
          indicatorWeight: 6,
          labelColor: Colors.black,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Anta"
          ),
          unselectedLabelColor: Colors.black54,

        ),
        body: Container(
          child: TabBarView(
            children: [
              AllRegistrationRequest(),
              AllVerifiedAccounts(),
              AllBlockedAccounts(),
            ],
          ),
        ),
      ),
    );
  }
}
