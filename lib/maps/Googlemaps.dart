import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


class MapsExtension extends StatefulWidget {
  const MapsExtension({Key? key}) : super(key: key);

  @override
  State<MapsExtension> createState() => _MapsExtensionState();
}

class _MapsExtensionState extends State<MapsExtension> {



  final Completer<GoogleMapController> _controller =Completer();
  late GoogleMapController newMap;




  static const LatLng source =LatLng(9.6724359, 76.3895414);
  static const LatLng destination =LatLng(9.6699072,76.3883354);

  final appBar = AppBar(

    title: const Text("Map testing",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(
          children : [
            GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,



            initialCameraPosition: const CameraPosition(
                target: source,
                zoom: 15,
            ),

            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
              newMap=controller;
            },

            markers:{
              const Marker(
                markerId: MarkerId("source"),
                position: source,

              ),
              const Marker(
                markerId: MarkerId("destination"),
                position: destination,

              ),},
          ),
  ]
      ),
    );
  }


  Widget Gmaps(){
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
          target: source,
          zoom: 14.5
      ),
      markers:{
        const Marker(
          markerId: MarkerId("source"),
          position: source,

        ),
        const Marker(
          markerId: MarkerId("destination"),
          position: destination,

        ),},
    );
  }
}
