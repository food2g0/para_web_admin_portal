import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:para_web_admin_portal/mainScreen/dashboard_screen.dart';
import 'package:para_web_admin_portal/tabPages/accounts_tab.dart';



class AllRegistrationRequest extends StatefulWidget
{
  const AllRegistrationRequest({super.key});

  @override
  State<AllRegistrationRequest> createState() => _AllRegistrationRequestState();
}




class _AllRegistrationRequestState extends State<AllRegistrationRequest>
{
  QuerySnapshot? allRequestAccount;

  displayDialogBoxForRequestAccounts(userDocumentID)
  {
    return showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: const Text(
              "Verify Account",
              style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold
              ),
            ),
            content: const Text(
              "Do you want to verify this account?",
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
                child: const Text("No"),
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
                        "Verified Successfully.",
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
                child: const Text("Yes"),
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
        .where("status", isEqualTo: "unverified").get().then((allDriversRequestAccount)
    {
      setState(() {
        allRequestAccount = allDriversRequestAccount;
      });
    });
  }





  @override
  Widget build(BuildContext context)
  {
    {
      if(allRequestAccount != null)
      {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allRequestAccount!.docs.length,
          itemBuilder: (context, i)
          {
            return SizedBox(
              height: 110,
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
                                image: NetworkImage(allRequestAccount!.docs[i].get("driverPhotoUrl")),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        title: Column(
                          children: [
                            Text(
                              allRequestAccount!.docs[i].get("driverName"),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              allRequestAccount!.docs[i].get("driverEmail"),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green
                          ),
                          icon: const Icon(
                            Icons.person_pin_sharp,
                            color: Colors.white,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Verify".toUpperCase() + "\n" + "Account".toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                          onPressed: ()
                          {
                            displayDialogBoxForRequestAccounts(allRequestAccount!.docs[i].id);
                          },
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
