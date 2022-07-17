import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:r456/DriverLogin.dart';

class databaseoperations extends StatefulWidget {
  const databaseoperations({Key? key}) : super(key: key);

  @override
  State<databaseoperations> createState() => _databaseoperationsState();
}

class _databaseoperationsState extends State<databaseoperations> {
  Future<Firebase> _initializeFirebase() async {
    Firebase firebaseApp = (await Firebase.initializeApp()) as Firebase;
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.done){
                return const DriverLogin();
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
      ),
    );
  }
}
