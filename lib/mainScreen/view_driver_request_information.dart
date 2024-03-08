import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewDriverRequestAccount extends StatefulWidget {
  final String driverName;
  final String driverEmail;
  final String driverPhotoUrl;

  const ViewDriverRequestAccount({
    required this.driverName,
    required this.driverEmail,
    required this.driverPhotoUrl,
    required plate_number,
    required vehicle_color,
    required vehicle_model,
  });

  @override
  State<ViewDriverRequestAccount> createState() => _ViewDriverRequestAccountState();
}

class _ViewDriverRequestAccountState extends State<ViewDriverRequestAccount> {
  String? plate_number;
  String? vehicle_color;
  String? vehicle_model;

  @override
  void initState() {
    super.initState();
    fetchAdditionalInfo();
  }

  void fetchAdditionalInfo() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('drivers')
          .get();

      // Iterate over each document in the query snapshot
      querySnapshot.docs.forEach((documentSnapshot) {
        // Access the vehicle details fields
        setState(() {
          plate_number = documentSnapshot.get('vehicle_details.plate_number');
          vehicle_color = documentSnapshot.get('vehicle_details.vehicle_color');
          vehicle_model = documentSnapshot.get('vehicle_details.vehicle_model');
        });

        // Add logic to handle the fetched data (e.g., store it in a list)
      });
    } catch (e) {
      print('Error fetching additional info: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Commuter's Account",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Anta"
            ),
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.driverPhotoUrl),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${widget.driverName}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${widget.driverEmail}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            if (plate_number != null && plate_number!.isNotEmpty)
              Text(
                'Plate Number: $plate_number',
                style: TextStyle(fontSize: 16),
              ),
            if (vehicle_color != null && vehicle_color!.isNotEmpty)
              Text(
                'Vehicle Color: $vehicle_color',
                style: TextStyle(fontSize: 16),
              ),
            if (vehicle_model != null && vehicle_model!.isNotEmpty)
              Text(
                'Vehicle Model: $vehicle_model',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
