import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class _CustomGoogleMapState extends StatefulWidget {
  const _CustomGoogleMapState({super.key});

  @override
  State<_CustomGoogleMapState> createState() => __CustomGoogleMapStateState();
}

class __CustomGoogleMapStateState extends State<_CustomGoogleMapState> {
   

  @override
  void initState() async{
     // ignore: await_only_futures
     CameraPosition cameraPosition=await CameraPosition(target: LatLng(30, 30));
    super.initState();
  }
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition: CameraPosition(target:LatLng(30, 30)));
  }
}