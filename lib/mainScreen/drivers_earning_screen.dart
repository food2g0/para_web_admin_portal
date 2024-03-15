import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DriversEarningScreen extends StatefulWidget {
  final String driverID;

  const DriversEarningScreen({Key? key, required this.driverID}) : super(key: key);

  @override
  State<DriversEarningScreen> createState() => _DriversEarningScreenState();
}

class _DriversEarningScreenState extends State<DriversEarningScreen> {

  Future<void> resetEarnings() async {
    try {
      // Reset Firestore data
      await FirebaseFirestore.instance.collection('drivers').doc(widget.driverID).update({
        'cash_earnings': 0.0,
        'gCash_earnings': 0.0,
        'referenceNumbers': FieldValue.delete(),
      });

      print("Earnings reset successfully.");

      // Update UI by triggering a rebuild
      setState(() {});
    } catch (error, stackTrace) {
      print("Error resetting earnings: $error");
      print(stackTrace);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Earning",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Anta",
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: resetEarnings,
              child: Text(
                "Reset",
                style: TextStyle(
                  fontFamily: "Anta",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('drivers').doc(widget.driverID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.hasData && snapshot.data!.exists) {
              var data = snapshot.data!.data() as Map<String, dynamic>?;

              double cashEarnings = data?['cash_earnings'] as double? ?? 0.0;
              double gCashEarnings = data?['gCash_earnings'] as double? ?? 0.0;
              List<dynamic>? referenceNumbers = data?['referenceNumbers'];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          'Cash Earnings:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          '${cashEarnings.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          'GCash Earnings:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          '${gCashEarnings.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (referenceNumbers != null && referenceNumbers.isNotEmpty)
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reference Numbers:',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildReferenceNumberColumns(referenceNumbers),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (referenceNumbers == null || referenceNumbers.isEmpty)
                      Text(
                        'No reference numbers available',
                        style: TextStyle(fontSize: 18),
                      ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No earnings data available'));
            }
          }
        },
      ),
    );
  }

  List<Widget> _buildReferenceNumberColumns(List<dynamic> referenceNumbers) {
    List<Widget> columns = [];
    int chunkSize = 10;
    for (int i = 0; i < referenceNumbers.length; i += chunkSize) {
      List<dynamic> chunk = referenceNumbers.sublist(i, i + chunkSize > referenceNumbers.length ? referenceNumbers.length : i + chunkSize);
      columns.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: chunk.map<Widget>((refNumber) {
            return Text(
              '$refNumber',
              style: TextStyle(fontSize: 18),
            );
          }).toList(),
        ),
      );
    }
    return columns;
  }
}
