import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import '../databaseoperations.dart';

class MapsExtension extends StatefulWidget {
  const MapsExtension({Key? key}) : super(key: key);

  @override
  State<MapsExtension> createState() => _MapsExtensionState();
}

class _MapsExtensionState extends State<MapsExtension> {

  @override
  void initState() {
    setCustomIcon();
    getPolyPoints();
    getCurrentLocation();
    super.initState();
  }
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController newMap;

  static const LatLng source = LatLng(9.6723510, 76.3897231);
  static const LatLng destination = LatLng(9.6699072, 76.3883354);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

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

  BitmapDescriptor sourceIcon  =BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon  =BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon  =BitmapDescriptor.defaultMarker;

  void setCustomIcon(){
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/img1.jpg').then((icon) {
          sourceIcon=icon;
    });
  }


  void getPolyPoints() async {
    PolylinePoints polyPoints = PolylinePoints();

    PolylineResult result = await polyPoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      printpts();
      print(result.points);
      result.points.forEach(
        (PointLatLng point) =>
            polylineCoordinates.add(LatLng(point.latitude, point.longitude)),
      );
      setState(() {
        printpts();
      });
    }
  }

  void printpts() {
    print("tedst");
    print(polylineCoordinates);
  }



  final appBar = AppBar(
    title: const Text(
      "Map testing",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(children: [
        //currentLocation==null?const Center(child: Text("loading"),):
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,

          initialCameraPosition: CameraPosition(

            target:
              //  LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                LatLng(source.latitude, source.longitude),



            zoom: 15,
          ),

          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
            newMap=controller;
          },

          polylines: {
            Polyline(
              polylineId: const PolylineId("route"),
              points: polylineCoordinates,
              color: Colors.blue,
              width: 6,
            ),
          },

          markers: {
             Marker(
              //icon:sourceIcon,
              markerId: const MarkerId("source"),
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
      ]),
    );
  }


}
