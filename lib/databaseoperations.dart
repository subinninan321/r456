

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:r456/RegCon.dart';
import 'package:r456/additionalfiles/CheckLoginForUser.dart';
import 'package:r456/appFunctions.dart';
String userEmailID="";
String userName="";
String userPhone="";
String userId="";




class DatabaseOperations extends StatefulWidget {
  const DatabaseOperations({Key? key}) : super(key: key);


  @override
  State<DatabaseOperations> createState() => _DatabaseOperationsState();
}


class _DatabaseOperationsState extends State<DatabaseOperations> {
  Future<Firebase> _initializeFirebase() async {
    Firebase firebaseApp = (await Firebase.initializeApp()) as Firebase;
    return firebaseApp;
  }

  @override
  void initState(){
    super.initState();
    userEmailID=FirebaseAuth.instance.currentUser!.email.toString();
  }

  Future putDriverData({required String name,required String mail,required String phone,}) async{
    final docDriver = FirebaseFirestore.instance.collection('driverdetails').doc(userEmailID);

    final driver= Driver(name: name, phone: phone, email: mail);

    final json= driver.toJson();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.done){
              return const CheckUserLogin();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }




  Future getDriverData() async{

    final docUser= FirebaseFirestore.instance.collection('driverdetails').doc(userEmailID);
    final snapshot = await docUser.get();

    if(snapshot.exists){
      Driver.fromJson(snapshot.data()!);
     // Driver.printdata();
     // print(Driver.returnString());
    }
  }
  



}



class Authentication {
  final FirebaseAuth firebaseAuth;
  Authentication(this.firebaseAuth);
  Stream<User?> get authState => firebaseAuth.idTokenChanges();


  //SIGN UP METHOD
  Future signUp({required String email, required String password,required name,required phone}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //write data to firebase
      userEmailID=FirebaseAuth.instance.currentUser!.email.toString();
      final docDriver = FirebaseFirestore.instance.collection('driverdetails').doc(userEmailID);

      final driver= Driver(name: name, phone: phone, email: email);

      final json= driver.toJson();
      await docDriver.set(json);
      

      //write data to firebase

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
        appFunctions().driverStatus("Email already used. Go to login page.");
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
        appFunctions().driverStatus("Wrong email/password.");
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
        appFunctions().driverStatus( "No user found.");
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
        appFunctions().driverStatus( "User disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
        appFunctions().driverStatus("Too many requests on this account.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          appFunctions().driverStatus("Server error, please try again later.");
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
        appFunctions().driverStatus( "Invalid Email address.");
          break;
        default:
          appFunctions().driverStatus( "Signup failed. Please try again.");
          break;
      }
    } catch(e){
      print(null);
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password).then((value) {
        if (value.user != null) {
          print("swrrt");
        }
      },);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          appFunctions().driverStatus("");
          "Email already used. Go to login page.";
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          appFunctions().driverStatus("Wrong email/password.");
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          appFunctions().driverStatus("No user found.");
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          appFunctions().driverStatus("User disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          appFunctions().driverStatus("Too many requests on this account.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          appFunctions().driverStatus("Server error, please try again later.");
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          appFunctions().driverStatus("Invalid Email address.");
          break;
        default:
          appFunctions().driverStatus("Signup failed. Please try again.");
          break;
      }
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    appFunctions().driverStatus("Logged out");
  }

}

class Driver {
  String id;
  String name;
  String phone;
  final String email;

  Driver({
    required this.name,
    required this.phone,
    required this.email,
    this.id = '',
  });

  returnString() => name;


  Driver.fromJson(Map<String, dynamic> json)
      : this(
    name: json['name']! as String,
    phone: json['phone']! as String,
    email:json['email']! as String ,
    id: json['id']! as String,
  );

  printdata()
  {
    print('name');
  }

  Map<String, dynamic> toJson()=>{
    'id' : id,
    'name': name,
    'email': email,
    'phone': phone,
  };

}

