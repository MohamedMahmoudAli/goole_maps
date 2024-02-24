import 'dart:convert';

import 'package:google_maps/models/place_details_model/place_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps/models/place_model/place_model.dart';

class GoogleMapsPlacesServices {
  final String baseUrl = "https://maps.googleapis.com/maps/api/place";
  final String apiKey = 'AIzaSyBpb2i-vgld0n2AjBJiTifgilbEtwBknbo';
  Future<List<PlaceModel>> getPredictions({
    required String input,
    required String sessionToken,
  }) async {
    var response = await http.get(Uri.parse(
        '$baseUrl/autocomplete/json?key=$apiKey&input=$input&sessiontoken=$sessionToken'));
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

  Future<PlaceDetailsModel> placeDetailsModel({required String placeId}) async {
    var response = await http
        .get(Uri.parse('$baseUrl/details/json?key=$apiKey&place_id=$placeId'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['result'];
      return PlaceDetailsModel.fromJson(data);
    } else {
      throw Exception();
    }
  }
}
