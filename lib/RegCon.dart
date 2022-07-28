import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r456/appFunctions.dart';
import 'package:r456/dashboard.dart';

import 'databaseoperations.dart';

class RegCon extends StatefulWidget {
  const RegCon({Key? key}) : super(key: key);

  @override
  State<RegCon> createState() => _RegConState();
}

class _RegConState extends State<RegCon> {


  addUserProfile() async{
    userEmailID=FirebaseAuth.instance.currentUser!.email.toString();
    final docDriver = FirebaseFirestore.instance.collection('driverdetails').doc(userEmailID).collection('Profile Details').doc();

    final driver = DriverProfile(
        nameOnLicence: _nameOnLicence.text,
        licenceNumber: _licenceNumber.text,
        district: _district.text,
        locality: _locality.text,
        state: _state.text,
        vehicleNumber: _vehicleNumber.text,
        vehicleModel: _vehicleModel.text,

    );

    final json= driver.toJson();
    await docDriver.set(json);
  }

  final TextEditingController _nameOnLicence = TextEditingController();
  final TextEditingController _licenceNumber = TextEditingController();
  final TextEditingController _vehicleNumber = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _locality = TextEditingController();
  final TextEditingController _vehicleModel = TextEditingController();
  final TextEditingController _ = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 24,
          color: Colors.white,
        ),
        title: const Text(
          "Continue Your Registration",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          width: double.infinity,
          // constraints: const BoxConstraints.expand(),
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage("assets/img1.jpg"), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 40,
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(

                  children: <Widget>[
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Driving Licence',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),
                        appFunctions()
                            .inputField(label: 'Name On Driving Licence',ctrl: _nameOnLicence),
                        appFunctions().inputField(label: 'Licence No',ctrl: _licenceNumber),
                        appFunctions().inputField(label: 'Valid Till'),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Region Information',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        appFunctions().inputField(label: 'State',ctrl: _state),
                        appFunctions().inputField(label: 'District',ctrl: _district),
                        appFunctions().inputField(label: 'Locality',ctrl: _locality),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Vehicle Information',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        appFunctions().inputField(label: 'Vehicle Number',ctrl: _vehicleNumber),
                        appFunctions().inputField(label: 'Vehicle Model',ctrl: _vehicleModel),
                        appFunctions().inputField(label: 'Valid Till'),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              )),
              Column(
                children: <Widget>[
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      try {

                        //enter data
                        addUserProfile();
                        //enter data


                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const dashboard()));
                      } catch (e) {
                        print(e);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DriverProfile {
  String nameOnLicence;
  String licenceNumber;
  String vehicleNumber;
  String state;
  String district;
  String locality;
  String vehicleModel;


  DriverProfile({
    required this.nameOnLicence,
    required this.licenceNumber,
    required this.district,
    required this.locality,
    required this.state,
    required this.vehicleNumber,
    required this.vehicleModel,
  });


  DriverProfile.fromJson(Map<String, dynamic> json)
      : this(
    nameOnLicence: json['name']! as String,
    licenceNumber: json['phone']! as String,
    locality:json['email']! as String ,
    district: json['id']! as String,
    state: json['id']! as String,
    vehicleNumber: json['id']! as String,
    vehicleModel: json['id']! as String,
  );

  Map<String, dynamic> toJson()=>{
    'Name on License' : nameOnLicence,
    'License Number': licenceNumber,
    'Locality': locality,
    'District': district,
    'State': state,
    'Vehicle Number': vehicleNumber,
    'Vehicle Model' : vehicleModel,
  };

}
