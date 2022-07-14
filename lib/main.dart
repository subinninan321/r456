import 'package:flutter/material.dart';
//import 'package:r456/DriverRegCon.dart';
//import 'package:r456/RegCon.dart';
import 'DriverLogin.dart';

void main() {
  runApp(const MyApp());
}

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
      home: const DriverLogin(),
    );
  }
}

