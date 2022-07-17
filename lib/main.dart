import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r456/DriverLogin.dart';
//import 'package:r456/DriverRegCon.dart';
//import 'package:r456/RegCon.dart';
//import 'DriverLogin.dart';
import 'dashboard.dart';
import 'databaseoperations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

DatabaseReference drRef = FirebaseDatabase.instance.ref().child("drivers");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'L-Taxi Driver App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //home: const DriverLogin(),
      home: const DriverLogin(),
      routes: {
        "login": (_) => const DriverLogin(),
      },
    );
  }
}

