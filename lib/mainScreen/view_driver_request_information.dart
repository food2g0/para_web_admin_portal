import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class ViewDriverRequestAccount extends StatefulWidget {
  final String driverName;
  final String driverEmail;
  final String driverPhotoUrl;
  final String plate_number;
  final String vehicle_color;
  final String vehicle_model;

  ViewDriverRequestAccount({
    required this.driverName,
    required this.driverEmail,
    required this.driverPhotoUrl,
    required this.plate_number,
    required this.vehicle_color,
    required this.vehicle_model,
  });

  @override
  State<ViewDriverRequestAccount> createState() => _ViewDriverRequestAccountState();
}

class _ViewDriverRequestAccountState extends State<ViewDriverRequestAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Driver Verification",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Anta",
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.driverPhotoUrl),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 300),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "PoppinsSemi",
                                    ),
                                  ),
                                  Text(
                                    '${widget.driverName}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "PoppinsReg",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "PoppinsSemi",
                                    ),
                                  ),
                                  Text(
                                    '${widget.driverEmail}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "PoppinsReg",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            if (widget.plate_number.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Plate Number:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "PoppinsSemi",
                                      ),
                                    ),
                                    Text(
                                      '${widget.plate_number}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "PoppinsReg",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            VerticalDivider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            if (widget.vehicle_color.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Vehicle Color:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "PoppinsSemi",
                                      ),
                                    ),
                                    Text(
                                      '${widget.vehicle_color}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "PoppinsReg",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            VerticalDivider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            if (widget.vehicle_model.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Vehicle Model:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "PoppinsSemi",
                                      ),
                                    ),
                                    Text(
                                      '${widget.vehicle_model}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "PoppinsReg",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
