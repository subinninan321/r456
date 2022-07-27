
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r456/DriverLogin.dart';
import 'package:r456/dashboard.dart';
import 'package:r456/databaseoperations.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckUserLogin extends StatefulWidget {
  const CheckUserLogin({Key? key}) : super(key: key);

  @override
  State<CheckUserLogin> createState() => _CheckUserLoginState();
}

class _CheckUserLoginState extends State<CheckUserLogin> {
  void initSate(){
    super.initState();
  }


  @override
  Widget build(BuildContext context){


    final user = context.watch<User?>();



    if(user!=null)
      {
        return const dashboard();
      }
    else
      {
        return const DriverLogin();

      }
  }
}


