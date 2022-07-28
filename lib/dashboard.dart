import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:r456/DriverRegCon.dart';
import 'package:r456/HistoryPage.dart';
import 'package:r456/NavPanel.dart';
import 'package:r456/appFunctions.dart';
import 'package:r456/maps/Googlemaps.dart';
import 'package:r456/databaseoperations.dart';


import 'databaseoperations.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  @override
  void initState(){
    userEmailID=FirebaseAuth.instance.currentUser!.email.toString();
    getCurrentUserData();
    getCurrentLocation();
    super.initState();
  }

  //firebase

  getCurrentUserData() async{
    FirebaseFirestore.instance.collection('driverdetails').doc(userEmailID).get().then((value) {

    currentUserName=value.get('name').toString();
    });
  }

  String currentUserName="name";

  //firebase

  bool value = false;
  int flag = 0;
  bool rideStatus=true;
  bool driverOnlineStatus=false;
  bool userPickupStatus=false;
  bool rideCompleteStatus=false;
  bool rideRequestStatus=false;

  //liveloc up
  final Location location=Location();
  LocationData? currentLocation;
  StreamSubscription<LocationData>? locationChange;


  //liveloc up



  final appBar = AppBar(
    title: const Text("Dashboard",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),),

  );
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController newMap;

  static const LatLng source = LatLng(9.6723510, 76.3897231);
  static const LatLng destination = LatLng(9.6699072, 76.3883354);



  void getCurrentLocation() async{
    Location location = Location();

    GoogleMapController googleMapController=await _controller.future;

    location.getLocation().then((location) {
      currentLocation = location;
    });

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 15.5,
              target: LatLng(
                  newLoc!.latitude!,
                  newLoc!.longitude!
              )
          )
      )
      );
      setState(() {});
    });
  }

  addLocation() async{
    try{
      final LocationData resLocData=await location.getLocation();
      await FirebaseFirestore.instance.collection('DriverLocations').doc(userEmailID).set({
        'latitude':resLocData.latitude,
        'longitude':resLocData.longitude,
        'email':userEmailID,
      },SetOptions(merge: true));
      
    }catch(e){
      print(e);
        }

  }
  
  Future updateLocation() async{
    locationChange = location.onLocationChanged.handleError((onError){
      print(onError);
      locationChange?.cancel();
      setState(() {
        locationChange=null;
      });
    }).listen((currentLocation) async{
      await FirebaseFirestore.instance.collection('DriverLocations').doc(userEmailID).set({
        'latitude':currentLocation.latitude,
        'longitude':currentLocation.longitude,
        'email':userEmailID,
      },SetOptions(merge: true));
    });
  }

  removeLocation(){
    locationChange?.cancel();
    setState(() {
      locationChange=null;
      FirebaseFirestore.instance.collection('DriverLocations').doc(userEmailID).delete().
      then((value) => appFunctions().driverStatus('you are offline'));
    });
  }


  Widget statusSwitch()=>Transform.scale(
    scale: 1.5,
    child:Switch.adaptive(
      value: value,
      activeColor: Colors.blueAccent,
      activeTrackColor: Colors.greenAccent,
      inactiveThumbColor: Colors.red,
      inactiveTrackColor: Colors.black,
      onChanged:(value) =>setState((){
        this.value=value;
        if(value){
          addLocation();
          updateLocation();
          rideStatus=!rideStatus;
          driverOnlineStatus=!driverOnlineStatus;
          flag=1;


        }
        else{
          removeLocation();
          flag=0;
          rideStatus=!rideStatus;
          driverOnlineStatus=!driverOnlineStatus;
        }
      }),
    ),
  );



  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final scrnHeight =queryData.size.height;
    final barHeight =appBar.preferredSize.height;
    final stbarHeight=queryData.padding.top;
    final conHeight=(scrnHeight-barHeight-stbarHeight);

    Widget acceptRide(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          const Text("From : ",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text("To   : ",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text("Fare : ",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Container(
            padding:const EdgeInsets.only(left: 10,right: 10,top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                MaterialButton(
                  minWidth: queryData.size.width*0.4,
                  height: 40,
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const MapsExtension()));
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Accept",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),

                  ),
                ),

                const SizedBox(width: 10,),
                MaterialButton(
                  color: Colors.blue,
                  minWidth: queryData.size.width*0.4,
                  height: 40,
                  onPressed: () {
                    appFunctions().driverStatus("Online");
                    print("buuto");
                    print(value);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const HistoryPage()));
                  },
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Reject",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),

                  ),
                ),

              ],
            ),
          )

        ],

      );
    }
    Widget pickUser(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          const Text("From : ",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text("To   : ",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text("Fare : ",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Container(
            padding:const EdgeInsets.only(left: 10,right: 10,top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                MaterialButton(
                  minWidth: queryData.size.width*0.4,
                  height: 40,
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const MapsExtension()));
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Accept",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),

                  ),
                ),

                const SizedBox(width: 10,),
                MaterialButton(
                  color: Colors.blue,
                  minWidth: queryData.size.width*0.4,
                  height: 40,
                  onPressed: () {
                    appFunctions().driverStatus("Online");
                    print("buuto");
                    print(value);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const HistoryPage()));
                  },
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Reject",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),

                  ),
                ),

              ],
            ),
          )

        ],

      );
    }
    Widget completeRide(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          const Text("From : ",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text("To   : ",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text("Fare : ",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Container(
            padding:const EdgeInsets.only(left: 10,right: 10,top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                MaterialButton(
                  minWidth: queryData.size.width*0.4,
                  height: 40,
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const MapsExtension()));
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Accept",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),

                  ),
                ),

                const SizedBox(width: 10,),
                MaterialButton(
                  color: Colors.blue,
                  minWidth: queryData.size.width*0.4,
                  height: 40,
                  onPressed: () {
                    appFunctions().driverStatus("Online");
                    print("buuto");
                    print(value);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const HistoryPage()));
                  },
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Reject",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),

                  ),
                ),

              ],
            ),
          )

        ],

      );
    }


    Widget offlineStatus(){
      return

        Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>  [

         Container(
           padding:const  EdgeInsets.only(top: 50),
           child:const Align(
             alignment: Alignment.center,
             child: Text("You are offline.",
             style: TextStyle(
               fontSize: 25,
               fontWeight: FontWeight.bold,
               color: Colors.white,
             ),
               textAlign: TextAlign.center,
           ),
         )
         )
        ],
      );}
    Widget onlineStatus(){
      return

        Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>  [

         Container(
           padding:const  EdgeInsets.only(top: 50),
           child:const Align(
             alignment: Alignment.center,
             child: Text("Searching for ride requests",
             style: TextStyle(
               fontSize: 25,
               fontWeight: FontWeight.bold,
               color: Colors.white,
             ),
               textAlign: TextAlign.center,
           ),
         )
         )
        ],
      );}




    return Scaffold (
      resizeToAvoidBottomInset: false,
      drawer: const NavPanel(),
      appBar: appBar,
      body: SafeArea(
        child: Container(
          color: const Color(0xfff0f2fd),
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          width: double.infinity,
          height: conHeight,
          child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                color:const Color(0xffa1a19f),
                shape:const  RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20)),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: conHeight*0.2,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Welcome back",
                        textAlign: TextAlign.start,
                        style:TextStyle(
                          fontSize:18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5,),

                      const SizedBox(height: 5,),
                       Text(currentUserName,
                      textAlign: TextAlign.center,
                      style:const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      ),
                      const SizedBox(height: 5,),
                      Center(
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget> [
                          const Text("Ready to drive",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Center(child: statusSwitch()),
                          ),
                          ],
                        ),
                      )
                    ],

                  ),
                 ),
              ),
              Card(
                color: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: double.infinity,
                  height: conHeight*0.47,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 5,
                    //     offset: const Offset(0,3),
                    //   ),
                    // ],
                  ),
                  child:GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,

                    initialCameraPosition: const CameraPosition(target: source, zoom: 16),

                    onMapCreated: (GoogleMapController controller){
                      _controller.complete(controller);
                      newMap=controller;
                    },
                    markers: {
                      const Marker(
                        markerId: MarkerId("source"),
                        position: source,
                      ),
                      const Marker(
                        markerId: MarkerId("destination"),
                        position: destination,
                      ),

                      // Marker(
                      //   markerId: const MarkerId("current location"),
                      //   position: LatLng(
                      //       currentLocation!.latitude!, currentLocation!.longitude!),
                      // ),
                    },
                  ),


                 ),
              ),
              Card(// for ride request
                color: const Color(0xffa1a19f),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
                child: Container(
                  width: double.infinity,
                  height: conHeight*0.25,
                  padding: const EdgeInsets.all(10),

                  child:Column(
                    children: [
                      Visibility(
                          visible: rideRequestStatus,
                          child: acceptRide()),
                      Visibility(
                          visible: rideStatus,
                          child: offlineStatus()),
                      Visibility(
                          visible: driverOnlineStatus,
                          child: onlineStatus()),
                      Visibility(
                          visible: userPickupStatus,
                          child: pickUser()),
                      Visibility(
                          visible: rideCompleteStatus,
                          child: completeRide()),

                    ],
                  ),
                 ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
