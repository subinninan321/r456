import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:r456/appFunctions.dart';

import '../main.dart';



class  RideRequest extends StatefulWidget{


  RideRequest({Key? key}) : super(key: key);

  @override
  State<RideRequest> createState() => _RideRequestState();
}

class _RideRequestState extends State<RideRequest> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




class PushNotification{




  Future<String?> getToken() async{
    String? token = await FirebaseMessaging.instance.getToken();
    print("n\n\\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    print(token);
    print(token);
    print(token);
    print(token);
    print(token);
    appFunctions().driverStatus(token!.toString());
  }
 final FirebaseMessaging firebaseMessaging= FirebaseMessaging.instance;

  Future initialize() async{

  }

}