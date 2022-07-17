import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r456/DriverLogin.dart';
import 'package:r456/HistoryPage.dart';
import 'package:r456/appFunctions.dart';
import 'package:r456/dashboard.dart';

class NavPanel extends StatelessWidget {
  const NavPanel({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("qwert"),
              accountEmail: Text("adfd"),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                      'img1.jpg',
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
            title: const Text('Edit'),
            onTap: () => print('edt'),
          ),
          ListTile(
            leading: const Icon(Icons.history_sharp),
            title: const Text('History'),
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const HistoryPage())),
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
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushNamedAndRemoveUntil(
                      context, "login", (Route<dynamic> route) => false);
                  appFunctions().driverStatus("Successfully Signed Out");
                });
              }),
        ],
      ),
    );
  }
}

