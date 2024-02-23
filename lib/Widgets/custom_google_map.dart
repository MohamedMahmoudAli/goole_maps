import 'package:flutter/material.dart';
import 'package:google_maps/Widgets/custom_list_view.dart';
import 'package:google_maps/models/place_model/place_model.dart';
import 'package:google_maps/utils/google_maps_google_places_services.dart';
import 'package:google_maps/utils/location_services.dart';
import 'package:google_maps/widgets/customTextField.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMapState extends StatefulWidget {
  const CustomGoogleMapState({super.key});

  @override
  State<CustomGoogleMapState> createState() => _CustomGoogleMapStateState();
}

class _CustomGoogleMapStateState extends State<CustomGoogleMapState> {
  late CameraPosition initalCameraPosition;
  late TextEditingController textEditingController;
  late GoogleMapsPlacesServices googleMapsPlacesServices;
  Set<Marker> markers = {};
  List<PlaceModel> places = [];
  @override
  void initState() {
    googleMapsPlacesServices = GoogleMapsPlacesServices();
    textEditingController = TextEditingController();
    initalCameraPosition = const CameraPosition(zoom: 0, target: LatLng(0, 0));
    locationService = LocationService();
    updateCurrentLocation();
    fetchPredictions();
    super.initState();
  }

  void fetchPredictions() async {
    textEditingController.addListener(() async {
      if (textEditingController.text.isNotEmpty) {
        var result = await googleMapsPlacesServices.getPredictions(
            input: textEditingController.text);
        places.clear();
        places.addAll(result);
        setState(() {});
      } else {
        places.clear();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
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
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Column(
            children: [
              CustomTextField(
                textEditingController: textEditingController,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomListView(
                places: places,
              )
            ],
          ),
        )
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
          CameraPosition(target: currentLocation, zoom: 16);
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
