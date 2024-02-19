
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMapState extends StatefulWidget {
  const CustomGoogleMapState({super.key});

  @override
  State<CustomGoogleMapState> createState() => _CustomGoogleMapStateState();
}

class _CustomGoogleMapStateState extends State<CustomGoogleMapState> {
  late  CameraPosition initalCameraPosition;
  @override
  void initState() {
      initalCameraPosition=   const CameraPosition(
        zoom: 0,
        target: LatLng(0, 0)
        );
        location=Location();
        location.requestPermission();


    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  late Location location;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        GoogleMap(
          
          zoomControlsEnabled: false,
          onMapCreated:(controller) {
            
          },
          initialCameraPosition:initalCameraPosition 
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: ElevatedButton(onPressed: (){
              }, child: const Text("change the postion ")))
      ],
    );
  }
  getLocationPermision()async{
    var hasPermision =await location.hasPermission();
    if(hasPermision!=null){
      location.requestPermission();

    }
  }
}