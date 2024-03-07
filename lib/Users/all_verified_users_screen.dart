import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:para_web_admin_portal/mainScreen/dashboard_screen.dart';




class AllVerifiedUsersScreen extends StatefulWidget
{
  const AllVerifiedUsersScreen({super.key});

  @override
  State<AllVerifiedUsersScreen> createState() => _AllVerifiedUsersScreenState();
}




class _AllVerifiedUsersScreenState extends State<AllVerifiedUsersScreen>
{
  QuerySnapshot? allUsers;

  displayDialogBoxForBlockingAccounts(userDocumentID)
  {
    return showDialog(
        context: context,
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: const Text(
            "Block Account",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 2,
              fontWeight: FontWeight.bold
            ),
          ),
          content: const Text(
            "Do you want to block this account?",
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
                  "status": "not approved"
                };

                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userDocumentID)
                    .update(userDataMap)
                    .then((value)
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const DashboardScreen()));

                  SnackBar snackBar = const SnackBar(
                    content: Text(
                      "Blocked Successfully.",
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
        .collection("users")
        .where("status", isEqualTo: "approved").get().then((allVerifiedUsers)
    {
      setState(() {
        allUsers = allVerifiedUsers;
      });
    });
  }





  @override
  Widget build(BuildContext context)
  {
    {
      if(allUsers != null)
      {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allUsers!.docs.length,
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
                                 image: NetworkImage(allUsers!.docs[i].get("userPhotoUrl")),
                                 fit: BoxFit.fill,
                               ),
                             ),
                           ),
                         ),
                         title: Column(
                           children: [
                             Text(
                                 allUsers!.docs[i].get("userName"),
                               style: const TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold
                               ),
                             ),
                             Text(
                               allUsers!.docs[i].get("userEmail"),
                               style: const TextStyle(
                                 fontSize: 16,
                               ),
                             ),
                           ],
                         ),
                         trailing: ElevatedButton.icon(
                               style: ElevatedButton.styleFrom(
                                 primary: Colors.red
                               ),
                               icon: const Icon(
                                 Icons.block_outlined,
                                 color: Colors.white,
                               ),
                               label: Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Text(
                                   "Block".toUpperCase() + "\n" + "Account".toUpperCase(),
                                   style: const TextStyle(
                                     fontSize: 11,
                                     color: Colors.white,
                                     letterSpacing: 3,
                                   ),
                                 ),
                               ),
                               onPressed: ()
                               {
                                 displayDialogBoxForBlockingAccounts(allUsers!.docs[i].id);
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
