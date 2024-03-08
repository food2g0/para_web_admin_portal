import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:para_web_admin_portal/mainScreen/dashboard_screen.dart';




class AllBlockedDriversScreen extends StatefulWidget
{
  const AllBlockedDriversScreen({super.key});

  @override
  State<AllBlockedDriversScreen> createState() => _AllBlockedDriversScreenState();
}




class _AllBlockedDriversScreenState extends State<AllBlockedDriversScreen>
{
  QuerySnapshot? allDrivers;

  displayDialogBoxForUnblockingAccounts(userDocumentID)
  {
    return showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: const Text(
              "Unblock Account",
              style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold
              ),
            ),
            content: const Text(
              "Do you want to unblock this account?",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                ),
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                child: const Text("No",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Anta"
                ),),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green
                ),
                onPressed: ()
                {
                  Map<String, dynamic> userDataMap =
                  {
                    "status": "approved"
                  };

                  FirebaseFirestore.instance
                      .collection("drivers")
                      .doc(userDocumentID)
                      .update(userDataMap)
                      .then((value)
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const DashboardScreen()));

                    SnackBar snackBar = const SnackBar(
                      content: Text(
                        "Unblocked Successfully.",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.greenAccent,
                      duration: Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: const Text("Yes",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Anta"
                  ),),
              ),
            ],
          );
        }
    );
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("drivers")
        .where("status", isEqualTo: "not approved").get().then((allVerifiedDrivers)
    {
      setState(() {
        allDrivers = allVerifiedDrivers;
      });
    });
  }





  @override
  Widget build(BuildContext context)
  {
    {
      if(allDrivers != null)
      {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allDrivers!.docs.length,
          itemBuilder: (context, i)
          {
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
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              allDrivers!.docs[i].get("driverEmail"),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: Colors.green, // Button background color
                            borderRadius: BorderRadius.circular(5), // Button border radius
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.check,
                              color: Colors.white, // Icon color
                            ),
                            onPressed: () {
                              displayDialogBoxForUnblockingAccounts(allDrivers!.docs[i].id);
                            },
                          ),
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
      else
      {
        return const Center(
          child: Text(
            "No Record Found",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        );
      }
    }
  }
}
