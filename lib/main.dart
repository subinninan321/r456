import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r456/DriverLogin.dart';
import 'package:r456/additionalfiles/CheckLoginForUser.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:r456/maps/Googlemaps.dart';
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


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    super.initState();
    checkPermissions();
  }


  void checkPermissions() async{
    PermissionStatus locStatus= await Permission.location.request();

    if(locStatus== PermissionStatus.granted){

    }
    if(locStatus==PermissionStatus.denied){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("This is required")));

    }

    if(locStatus==PermissionStatus.permanentlyDenied){
      openAppSettings();
    }

  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authentication?>(
          create: (_)=> Authentication(FirebaseAuth.instance),
        ),
        StreamProvider(create: (context) => context.read<Authentication>().authState, initialData: null,)
      ],


      child: MaterialApp(
        title: 'L-Taxi Driver App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color(0xff1c1c1a),
          ),
          primarySwatch: Colors.blue,
        ),
        home: const CheckUserLogin(),
        routes: {
          "login": (_) => const CheckUserLogin(),
        },
      ),

    );
  }
}



