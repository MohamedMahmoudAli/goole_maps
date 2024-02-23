import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:google_maps/models/place_model/place_model.dart';

class GoogleMapsPlacesServices {
  final String baseUrl = "https://maps.googleapis.com/maps/api/place";
  final String apiKey = 'AIzaSyBpb2i-vgld0n2AjBJiTifgilbEtwBknbo';
  Future<List<PlaceModel>> getPredictions({
    required String input,
  }) async {
    var response = await http
        .get(Uri.parse('$baseUrl/autocomplete/json?key=$apiKey&input=$input'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['predictions'];
      List<PlaceModel> places = [];
      for (var item in data) {
        places.add(PlaceModel.fromJson(item));
      }
      return places;
    } else {
      throw Exception();
    }
  }

  Future<PlaceModel> placeDetailsModel({required String placeId}) async {
    var response = await http
        .get(Uri.parse('$baseUrl/details/json?key=$apiKey&place_id=$placeId'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['result'];
      return PlaceModel.fromJson(data);
    } else {
      throw Exception();
    }
  }
}
