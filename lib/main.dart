import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:para_web_admin_portal/authentications/login_screen.dart';
import 'package:para_web_admin_portal/mainScreen/dashboard_screen.dart';





Future main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb)
  {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA8nvFegKbXQ8P3VVOGI81tO2hbx5KZYiE",
            appId: "1:479298090231:web:8759c7e448a3f24a4ccff2",
            messagingSenderId: "479298090231",
            projectId: "ride-hailing-app-64ad6"
        ),
    );
  }


  await Firebase.initializeApp();

  runApp(MyApp());
}




class MyApp extends StatelessWidget
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Web Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? const LoginScreen() : const DashboardScreen(),
    );
  }
}
