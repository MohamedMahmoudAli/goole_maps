import 'geometry.dart';
import 'photo.dart';

class PlaceDetailsModel {
  List<dynamic>? addressComponents;
  String? adrAddress;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photo>? photos;
  String? placeId;
  String? reference;
  List<dynamic>? types;
  String? url;
  int? utcOffset;
  String? vicinity;

  PlaceDetailsModel({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.photos,
    this.placeId,
    this.reference,
    this.types,
    this.url,
    this.utcOffset,
    this.vicinity,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsModel(
      addressComponents: json['address_components'] as List<dynamic>?,
      adrAddress: json['adr_address'] as String?,
      formattedAddress: json['formatted_address'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      icon: json['icon'] as String?,
      iconBackgroundColor: json['icon_background_color'] as String?,
      iconMaskBaseUri: json['icon_mask_base_uri'] as String?,
      name: json['name'] as String?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      types: json['types'] as List<dynamic>?,
      url: json['url'] as String?,
      utcOffset: json['utc_offset'] as int?,
      vicinity: json['vicinity'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'address_components': addressComponents,
        'adr_address': adrAddress,
        'formatted_address': formattedAddress,
        'geometry': geometry?.toJson(),
        'icon': icon,
        'icon_background_color': iconBackgroundColor,
        'icon_mask_base_uri': iconMaskBaseUri,
        'name': name,
        'photos': photos?.map((e) => e.toJson()).toList(),
        'place_id': placeId,
        'reference': reference,
        'types': types,
        'url': url,
        'utc_offset': utcOffset,
        'vicinity': vicinity,
      };
}
