import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:r456/DriverRegCon.dart';
import 'package:r456/HistoryPage.dart';
import 'package:r456/NavPanel.dart';
import 'package:r456/appFunctions.dart';
import 'package:r456/maps/Googlemaps.dart';

import 'databaseoperations.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  bool value = false;
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


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final scrnHeight =queryData.size.height;
    final barHeight =appBar.preferredSize.height;
    final stbarHeight=queryData.padding.top;
    final conHeight=(scrnHeight-barHeight-stbarHeight);
    int flag = 0;


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
            flag=1;
          }
          else{
            flag=0;
          }
        }),
      ),
    );

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
                      const Text("Welcome{Driver().passData()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5,),

                      const SizedBox(height: 5,),
                      const Text("Vehicle Number : ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
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
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  width: double.infinity,
                  height: conHeight*0.47,

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
