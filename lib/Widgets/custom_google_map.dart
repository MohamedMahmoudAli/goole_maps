
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui'as ui;

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
        zoom: 10.0,
        target: LatLng(31.227212467987233, 29.97218040398892)
        );
        // initMapStyle(); 
        // initMarkers();
        location=Location();

        checkAndRequestLocationService();
    super.initState();
  }
  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }
  Set<Marker>myMarkers={};
  Set<Polyline>myPolylines={};
    Set<Polygon>myPolygn={};
    Set<Circle>myCircels={};
    late Location location;

  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        GoogleMap(
          circles:myCircels,
          // polylines: myPolylines,
          // markers: myMarkers,
          polygons: myPolygn,
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
  


  // to change the size of the image
  Future<Uint8List>getImageFromRawData(String image,int width)async{
    var imageData=await rootBundle.load(image);
    var imageCodec= await ui.instantiateImageCodec(imageData.buffer.asUint8List(),targetWidth: width.round());
     var imageframe =await imageCodec.getNextFrame();
     var imagebytedata=await imageframe.image.toByteData(format: ui.ImageByteFormat.png);
     return imagebytedata!.buffer.asUint8List();
  }
  // to use customize style for map
  void initMapStyle()async {
    var nightMapStyle=await DefaultAssetBundle
    .of(context)
    .loadString('assets/mapstyles/nightmapstyle/nightmapstyle.json');
    googleMapController.setMapStyle(nightMapStyle);


  }
  // to make markers in the map
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
  
  void initpolyines() {
    Polyline polyline=const Polyline(
      polylineId: PolylineId("1"),
      color: Colors.red,
      startCap: Cap.roundCap,
      zIndex: 0,
      width: 5,
      points: [
        LatLng(31.221803637504525, 29.995063172243356),
        LatLng(31.16944139293603, 29.93257440862772),
        LatLng(31.265416697378857, 29.98422328467738),
        LatLng(31.216891302339317, 29.887984445532872),

      ]
    );
    myPolylines.add(polyline);
    Polyline polyline2=const Polyline(
      //to make the line like curve 
      geodesic: true,
      patterns: [
        PatternItem.dot
      ],
      polylineId: PolylineId("2"),
      //the lowest value draw first 
      zIndex: 1,
      color: Colors.green,
      startCap: Cap.roundCap,
      width: 5,
      points: [
        LatLng(31.13756550911153, 29.835403464105443),
        LatLng(2.012271424911139, 23.659047362936324),

      ]
    );
    myPolylines.add(polyline2);
  }
  
  void initpolygns() {
    Polygon polygon= Polygon(polygonId: const PolygonId("1"),
    // strokeColor: Colors.red,
    fillColor: Colors.black.withOpacity(.5),
    points: const [
        LatLng(31.330850680097512, 30.077394967526413),
        LatLng(31.165197355884843, 29.81563264422966),
        LatLng(31.118261619430957, 30.126384005685303),

      ],
      holes: const [
        [
          LatLng(31.22946093522103, 29.97278441270375),
          LatLng(31.215441195798338, 29.939067905270303),
          LatLng(31.177339331182615, 30.021039230681893)
        ]
      
    ],
    );
    myPolygn.add(polygon);
  }
  
  void initCirecles() {
    var circle= Circle(circleId: const CircleId("1"),
    center: const LatLng(30.31546568720548, 31.188943683331996),
    radius: 500.0,
    fillColor: Colors.black.withOpacity(.5)

    );
    myCircels.add(circle);
  }
  
  void checkAndRequestLocationService() async{
    var isServicedEnabled=await location.serviceEnabled();
    if(!isServicedEnabled){
isServicedEnabled=await location.requestService();
if(!isServicedEnabled){
// to Do
  } 
  }
checkAndRequestLocationPremission();
}
void checkAndRequestLocationPremission() async{
  var permissionStatus=await location.hasPermission();
  if(permissionStatus==PermissionStatus.denied){
    permissionStatus=await location.requestPermission();
    if(permissionStatus!=PermissionStatus.granted){
    // TODO: Error Bar
  }
  }
}
void getLocationData(){
              location.onLocationChanged.listen((location) { });


}
}


// world view 0 -> 3
//country view 4 -> 6
//city view 10 ->12
//street view 13->17
//buildings view 18 ->20






