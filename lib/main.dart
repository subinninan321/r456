

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:r456/DriverLogin.dart';
import 'package:r456/additionalfiles/CheckLoginForUser.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:r456/maps/Googlemaps.dart';
import 'package:r456/maps/pushnotificationservice.dart';
//import 'package:r456/DriverRegCon.dart';
//import 'package:r456/RegCon.dart';
//import 'DriverLogin.dart';
import 'dashboard.dart';
import 'databaseoperations.dart';
import 'firebase_options.dart';


//notification


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  "High Importance Notifications", // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();




//notification

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //new code
  final messaging = FirebaseMessaging.instance.getInitialMessage();
  //
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );


 // listenForNotifications();
  //new code
  runApp(const MaterialApp(home:MyApp()));
}

listenForNotifications(){
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
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
    //new

    getMessage();




        //listen

    //on message


    //new

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


  //new

  final navigatorKey=GlobalKey<NavigatorState>();
  final _firebaseMessaging =FirebaseMessaging.instance.getInitialMessage();

  void getMessage(){

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("afafdsfasfsafsf\n \n\n\n\n\n\n\n\n\n\n\n\n");
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      print(message.toString());
      print(notification.toString());

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (android != null) {
        print("\n\n\n\n\\n\n\n\n\n\nn\ninstide if");
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                playSound: true,
                priority: Priority.high,
                color: Colors.blueAccent,
                channelDescription: channel.description,
                icon: "@mipmap/ic_launcher",
                // other properties...
              ),
            ));
        print("\n\n\n\n\\n\n\n\n\n\nn\ninstide i3f");
       final context = navigatorKey.currentState?.overlay?.context;
        print("\n\n\n\n\\n\n\n\n\n\nn\ninstide4 if");
        final dialog = AlertDialog(
          title: Text(notification.title.toString()),
          content: Text(notification.body.toString()),

        );
        print("\n\n\n\n\\n\n\n\n\n\nn\ninstide afsdfadsf if");
        showDialog(context: this.context, builder: (x) => dialog);
      }
    });

  }

  //new




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



