
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui'as ui;

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
        zoom: 10.0,
        target: LatLng(31.227212467987233, 29.97218040398892)
        );
        // initMapStyle(); 
        initMarkers();
    super.initState();
  }
  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }
  Set<Marker>myMarkers={};
  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        GoogleMap(
          zoomGesturesEnabled: false,
          markers: myMarkers,
          zoomControlsEnabled: false,
//mapType: MapType.terrain,
          onMapCreated:(controller) {
            googleMapController=controller;
            initMapStyle(); 
          },
          initialCameraPosition:initalCameraPosition 
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
  
  Future<Uint8List>getImageFromRawData(String image,int width)async{
    var imageData=await rootBundle.load(image);
    var imageCodec= await ui.instantiateImageCodec(imageData.buffer.asUint8List(),targetWidth: width.round());
     var imageframe =await imageCodec.getNextFrame();
     var imagebytedata=await imageframe.image.toByteData(format: ui.ImageByteFormat.png);
     return imagebytedata!.buffer.asUint8List();
  }
  void initMapStyle()async {
    var nightMapStyle=await DefaultAssetBundle
    .of(context)
    .loadString('assets/mapstyles/nightmapstyle/nightmapstyle.json');
    googleMapController.setMapStyle(nightMapStyle);


  }
  
  void initMarkers()async {
    // var myMarker=const Marker(markerId: MarkerId("1"),position: LatLng(31.227212467987233, 29.97218040398892));
    // Markers.add(myMarker);
    var customMarkerIcon= BitmapDescriptor.fromBytes(
      await getImageFromRawData(
        "assets/mapstyles/nightmapstyle/images/download.png",50)
     );
    var markers=modles.map(
      (placeModel) => Marker(
        icon:customMarkerIcon,
        infoWindow: InfoWindow(
          title: placeModel.name,
        ),
        markerId:MarkerId(placeModel.id.toString()),
        position: placeModel.latlng)
        ).toSet();
        myMarkers.addAll(markers);
        setState(() {});
        
  }
}



// world view 0 -> 3
//country view 4 -> 6
//city view 10 ->12
//street view 13->17
//buildings view 18 ->20






