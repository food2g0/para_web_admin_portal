import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:para_web_admin_portal/mainScreen/dashboard_screen.dart';
import 'package:para_web_admin_portal/mainScreen/view_drivers_information.dart';

class AllVerifiedDriversScreen extends StatefulWidget {
  const AllVerifiedDriversScreen({Key? key}) : super(key: key);

  @override
  State<AllVerifiedDriversScreen> createState() => _AllVerifiedDriversScreenState();
}

class _AllVerifiedDriversScreenState extends State<AllVerifiedDriversScreen> {
  QuerySnapshot? allDrivers;
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  displayDialogBoxForBlockingAccounts(userDocumentID) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Block Account",
            style: TextStyle(fontSize: 25, letterSpacing: 2, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Do you want to block this account?",
            style: TextStyle(fontSize: 16, letterSpacing: 2),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                  "No",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Anta"
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Map<String, dynamic> userDataMap = {"status": "not approved"};

                FirebaseFirestore.instance.collection("drivers").doc(userDocumentID).update(userDataMap).then((value) {
                  if (!_isDisposed) {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => const DashboardScreen()));

                    SnackBar snackBar = const SnackBar(
                      content: Text(
                        "Blocked Successfully.",
                        style: TextStyle(fontSize: 36, color: Colors.black),
                      ),
                      backgroundColor: Colors.greenAccent,
                      duration: Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
              child: const Text(
                  "Yes",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Anta"
                ),

              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance.collection("drivers").get().then((allVerifiedDrivers) {
      if (!_isDisposed) {
        setState(() {
          allDrivers = allVerifiedDrivers;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (allDrivers != null) {
      return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: allDrivers!.docs.length,
        itemBuilder: (context, i) {
          return SizedBox(
            height: 120,
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListTile(
                      leading: Transform.scale(
                        scale: 1.5,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(allDrivers!.docs[i].get("driverPhotoUrl")),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      title: Column(
                        children: [
                          Text(
                            allDrivers!.docs[i].get("driverName"),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            allDrivers!.docs[i].get("driverEmail"),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFFD600), // Button background color
                              borderRadius: BorderRadius.circular(5), // Button border radius
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.white, // Icon color
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (c) => ViewDriversAccount(
                                  driverName: allDrivers!.docs[i].get("driverName"),
                                  driverEmail: allDrivers!.docs[i].get("driverEmail"),
                                  driverPhotoUrl: allDrivers!.docs[i].get("driverPhotoUrl"),
                                  plate_number: allDrivers!.docs[i].get("vehicle_details.plate_number"),
                                  vehicle_color: allDrivers!.docs[i].get("vehicle_details.vehicle_color"),
                                  vehicle_model: allDrivers!.docs[i].get("vehicle_details.vehicle_model"),
                                  overallRatings: allDrivers!.docs[i].get("overallRatings"),
                                )));
                              },
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.lightGreen, // Button background color
                              borderRadius: BorderRadius.circular(5), // Button border radius
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.attach_money,
                                color: Colors.white, // Icon color
                              ),
                              onPressed: () {
                                // Handle earnings button press
                              },
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red, // Button background color
                              borderRadius: BorderRadius.circular(5), // Button border radius
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.block_outlined,
                                color: Colors.white, // Icon color
                              ),
                              onPressed: () {
                                displayDialogBoxForBlockingAccounts(allDrivers!.docs[i].id);
                              },
                            ),
                          ),

                        ],
                      ),



                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    else {
      return const Center(
        child: Text(
          "No Record Found",
          style: TextStyle(fontSize: 30),
        ),
      );
    }
  }
}
