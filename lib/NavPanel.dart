
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r456/DriverLogin.dart';
import 'package:r456/HistoryPage.dart';
import 'package:r456/additionalfiles/CheckLoginForUser.dart';
import 'package:r456/appFunctions.dart';
import 'package:r456/dashboard.dart';
import 'package:r456/databaseoperations.dart';

import 'editProfile.dart';


class NavPanel extends StatelessWidget {
  const NavPanel({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    userEmailID=FirebaseAuth.instance.currentUser!.email.toString();
    String currentUserName="";
    getCurrentUserData() async{
      FirebaseFirestore.instance.collection('driverdetails').doc(userEmailID).get().then((value) {

        currentUserName=value.get('name').toString();
      });
    }
    //const DatabaseOperations().getData();
    return Drawer(

    child: ListView(

        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("test"),
              accountEmail: Text(userEmailID),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                      'assets/img1.jpg',
                    width: 90,
                    height: 90,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_sharp),
            title: const Text('Dashboard'),
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const dashboard())),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Profile'),
            onTap: () =>Navigator.push(context,MaterialPageRoute(builder: (context) => const editProfile())) ,
          ),
          ListTile(
            leading: const Icon(Icons.history_sharp),
            title: const Text('History'),
            onTap: () => WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const HistoryPage()));
            }),
          ),
          ListTile(
            leading: const Icon(Icons.star_half_sharp),
            title: const Text('Ratings'),
            onTap: () => print('ratings'),
          ),
          ListTile(
            leading: const Icon(Icons.edit_notifications_sharp),
            title: const Text('Notifications'),
            onTap: () => print('Notification'),
          ),
          ListTile(
              leading: const Icon(Icons.logout_sharp),
              title: const Text('Logout'),
              onTap: () {
                context.read<Authentication>().signOut();
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const CheckUserLogin()));
              }),
        ],
      ),
    );
  }
}

