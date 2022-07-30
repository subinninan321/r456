import 'dart:async';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:r456/appFunctions.dart';
import 'package:r456/main.dart';
import 'package:r456/maps/pushnotificationservice.dart';
import '../databaseoperations.dart';

class MapsExtension extends StatefulWidget {
  const MapsExtension({Key? key}) : super(key: key);

  @override
  State<MapsExtension> createState() => _MapsExtensionState();
}

class _MapsExtensionState extends State<MapsExtension> {

  @override
  void initState() {
    getCurrentLocation();
    setCustomIcon();
    getPolyPoints();

    super.initState();
  }
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController newMap;

  static const LatLng source = LatLng(9.6723510, 76.3897231);
  static const LatLng destination = LatLng(9.6699072, 76.3883354);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  
  double distanceFromDriver=0.0;

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

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }


  void getPolyPoints() async {
    PolylinePoints polyPoints = PolylinePoints();

    PolylineResult result = await polyPoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      printpts();
      print(result.points);
      result.points.forEach(
        (PointLatLng point) =>
            polylineCoordinates.add(LatLng(point.latitude, point.longitude)),
      );

      double totalDistance=0.0;

      for(var i=0; i<polylineCoordinates.length-1;i++){
        totalDistance += calculateDistance( polylineCoordinates[i].latitude,
            polylineCoordinates[i].longitude,
            polylineCoordinates[i+1].latitude,
            polylineCoordinates[i+1].longitude);
      }
      print(totalDistance);

      setState(() {
        distanceFromDriver=totalDistance;
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
        color: Colors.white,
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
        FloatingActionButton(
            onPressed:  () {
                flutterLocalNotificationsPlugin.show(
                  0,
                  "testing$distanceFromDriver",
                  "aghjklf",
                  NotificationDetails(
                    android: AndroidNotificationDetails(
                      channel.id,
                      channel.name,
                      playSound: true,
                      priority: Priority.high,
                      color: Colors.blueAccent,
                      icon: "@mipmap/ic_launcher",
                      channelDescription: channel.description,

                    )
                  ),
                );


              // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
              // FlutterLocalNotificationsPlugin();
              // var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
              //     '1687497218170948721x8',
              //     'New Trips Notification ',
              //     channelDescription: 'Notification Channel for vendor. All the new trips notifications will arrive here.',
              //     // style: AndroidNotificationStyle.BigText,
              //     //styleInformation: bigTextStyleInformation);
              // );
              // var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
              //
              // flutterLocalNotificationsPlugin.show(5, 'Let\'s Get Wride!',
              //   'You Have Got A New Trip!', platformChannelSpecifics,);
                PushNotification().getToken();
              appFunctions().driverStatus("distance $distanceFromDriver");}),
      ]),
    );
  }


}
