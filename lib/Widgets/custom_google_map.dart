import 'package:flutter/material.dart';
import 'package:google_maps/utils/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMapState extends StatefulWidget {
  const CustomGoogleMapState({super.key});

  @override
  State<CustomGoogleMapState> createState() => _CustomGoogleMapStateState();
}

class _CustomGoogleMapStateState extends State<CustomGoogleMapState> {
  late CameraPosition initalCameraPosition;
  Set<Marker> markers = {};
  @override
  void initState() {
    initalCameraPosition = const CameraPosition(zoom: 0, target: LatLng(0, 0));
    locationService = LocationService();
    updateCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late Location location;
  late LocationService locationService;
  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            markers: markers,
            onMapCreated: (controller) {
              googleMapController = controller;
              updateCurrentLocation();
            },
            initialCameraPosition: initalCameraPosition),
      ],
    );
  }

  void updateCurrentLocation() async {
    try {
      var myLocation = await locationService.getCurrentLocation();

      LatLng currentLocation =
          LatLng(myLocation.latitude!, myLocation.longitude!);
      Marker marker = Marker(
          markerId: MarkerId("CurrentLocation"), position: currentLocation);
      CameraPosition cameraPosition =
          CameraPosition(target: currentLocation, zoom: 14);
      markers.add(marker);
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    } on LocationPermissionException catch (e) {
    } on LocationServiceException catch (p) {
    } catch (e) {}
  }
}
// create text field 
// listen to the text field
// search places
// display the results
