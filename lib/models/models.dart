import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latlng;

  PlaceModel({required this.id, required this.name, required this.latlng});
}

List<PlaceModel> modles = [
  PlaceModel(
      id: 1,
      name: "el falah",
      latlng: const LatLng(31.292522009334046, 30.014250470849298)),
  PlaceModel(
      id: 2,
      name: "el bablo",
      latlng: const LatLng(31.21386381469122, 29.91194029179508)),
  PlaceModel(
      id: 3,
      name: "el mohamamdy",
      latlng: const LatLng(31.21621276923145, 29.96755857705275))
];
