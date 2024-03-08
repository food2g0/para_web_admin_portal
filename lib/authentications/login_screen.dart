import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:para_web_admin_portal/mainScreen/dashboard_screen.dart';



class LoginScreen extends StatefulWidget
{
  const LoginScreen({Key? key}) : super(key: key);


  @override
  _LoginScreenState createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen>
{
  String adminEmail = "";
  String adminPassword = "";

  bool _obscureText = true;




  allowAdminToLogin() async
  {
    SnackBar snackBar = const SnackBar(
      content: Text(
        "Checking Credentials, Please wait...",
        style: TextStyle(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


    User? currentAdmin;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: adminEmail,
      password: adminPassword,
    ).then((fAuth)
    {
      //success
      currentAdmin = fAuth.user;
    }).catchError((onError)
    {
      //in case of error
      //display error message
      final snackBar = const SnackBar(
        content: Text(
          "Error Occurred, Please input correct email and password.",
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if(currentAdmin != null)
    {
      //check if that admin record also exists in the admins collection in firestore database
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get().then((snap)
      {
        if(snap.exists)
        {
          SnackBar snackBar = const SnackBar(
            content: Text(
              "Login Successful.",
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            backgroundColor: Colors.lightGreen,
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Future.delayed(const Duration(milliseconds: 3500), ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const DashboardScreen()));
          });

        }
        else
        {
          SnackBar snackBar = const SnackBar(
            content: Text(
              "No record found, you are not an admin.",
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Para: Admin",
                  style: TextStyle(
                      fontFamily: "ProtestRiot",
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: MediaQuery.of(context).size.width > 1800
                      ? EdgeInsets.only(left: 700, right: 700)
                      : MediaQuery.of(context).size.width < 1800 && MediaQuery.of(context).size.width > 1600
                      ? EdgeInsets.only(left: 600, right: 600)
                      : MediaQuery.of(context).size.width < 1600 && MediaQuery.of(context).size.width > 1400
                      ? EdgeInsets.only(left: 400, right: 400)
                      : MediaQuery.of(context).size.width < 1400 && MediaQuery.of(context).size.width > 1200
                      ? EdgeInsets.only(left: 350, right: 350)
                      : MediaQuery.of(context).size.width < 1200 && MediaQuery.of(context).size.width > 800
                      ? EdgeInsets.only(left: 200, right: 200)
                      : MediaQuery.of(context).size.width < 800 && MediaQuery.of(context).size.width > 700
                      ? EdgeInsets.only(left: 100, right: 100)
                      : EdgeInsets.only(left: 50, right: 50),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5), // Shadow color
                          spreadRadius: 10, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: Offset(0, 3), // Offset position
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_open_outlined,
                            size: MediaQuery.of(context).size.width * 0.1,
                            color: Colors.black,
                          ),

                          const SizedBox(height: 50,),

                          //email text field
                          TextField(
                            onChanged: (value)
                            {
                              adminEmail = value;
                            },
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black
                            ),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  )
                              ),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              icon: Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20,),

                          //password text field
                          TextField(
                            onChanged: (value)
                            {
                              adminPassword = value;
                            },
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black
                            ),
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  )
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  )
                              ),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: ()
                                {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              icon: const Icon(
                                Icons.password_outlined,
                                color: Colors.black,
                              ),

                            ),
                          ),

                          const SizedBox(height: 20,),


                          //login button
                          ElevatedButton(
                            onPressed: ()
                            {
                              allowAdminToLogin();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: MediaQuery.of(context).size.width > 200
                                  ? EdgeInsets.only(left: 90, right: 90, top: 20, bottom: 20)
                                  : MediaQuery.of(context).size.width < 200 && MediaQuery.of(context).size.width > 70
                                  ? EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20)
                                  : EdgeInsets.only(left: 10, right: 10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 25, right: 25),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  fontFamily: "Anta"
                                ),
                              ),
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
        ],
      ),
    );
  }
}
