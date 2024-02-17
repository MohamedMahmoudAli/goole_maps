import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMapState extends StatefulWidget {
  const CustomGoogleMapState({super.key});

  @override
  State<CustomGoogleMapState> createState() => _CustomGoogleMapStateState();
}

class _CustomGoogleMapStateState extends State<CustomGoogleMapState> {
  late  CameraPosition initalcameraPosition;
  // late  CameraPosition cameraPosition;

   

  @override
  void initState() {
      initalcameraPosition=   const CameraPosition(
        zoom: 10.0,
         
        target: LatLng(31.227212467987233, 29.97218040398892)
        );
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    googleMapController.dispose();
    super.dispose();
  }
  late GoogleMapController googleMapController;
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          mapType: MapType.terrain,
          onMapCreated:(controller) {
            googleMapController=controller;
          },
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(northeast:LatLng(31.304149778817113, 30.129218078926055)
          //  ,southwest:LatLng(31.098571048514753, 29.785458778301486) )
          //  ),
          initialCameraPosition:initalcameraPosition 
          
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: ElevatedButton(onPressed: (){
                
                googleMapController.animateCamera(
                  CameraUpdate.newLatLng(
                    const LatLng(30.317763810885676, 31.191159289815076)));
                 setState(() {
                  
                });
              }, child: const Text("change the postion ")))
      ],
    );
  }
}
// world view 0 -> 3
//country view 4 -> 6
//city view 10 ->12
//street view 13->17
//buildings view 18 ->20
