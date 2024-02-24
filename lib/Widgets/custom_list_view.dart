import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps/models/place_details_model/place_details_model.dart';
import 'package:google_maps/models/place_model/place_model.dart';
import 'package:google_maps/utils/google_maps_google_places_services.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.places,
    required this.googleMapsPlacesServices, required this.onPlaceSelect,
  });
  final List<PlaceModel> places;
  final GoogleMapsPlacesServices googleMapsPlacesServices;
  final Function(PlaceDetailsModel) onPlaceSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => ListTile(
                leading: const Icon(FontAwesomeIcons.mapPin),
                title: Text(places[index].description!),
                trailing: IconButton(
                  onPressed: () async {
                    var placeDetails =
                        await googleMapsPlacesServices.placeDetailsModel(
                            placeId: places[index].placeId.toString());
                            onPlaceSelect(placeDetails);

                  },
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ),
          separatorBuilder: (context, index) => const Divider(
                height: 0,
              ),
          itemCount: places.length),
    );
  }
}
