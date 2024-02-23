import 'structured_formatting.dart';
import 'term.dart';

class PlacesAutocompleteModel {
  String? description;
  List<dynamic>? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  List<Term>? terms;
  List<String>? types;

  PlacesAutocompleteModel({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  factory PlacesAutocompleteModel.fromJson(Map<String, dynamic> json) {
    return PlacesAutocompleteModel(
      description: json['description'] as String?,
      matchedSubstrings: json['matched_substrings'] as List<dynamic>?,
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structured_formatting'] == null
          ? null
          : StructuredFormatting.fromJson(
              json['structured_formatting'] as Map<String, dynamic>),
      terms: (json['terms'] as List<dynamic>?)
          ?.map((e) => Term.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: json['types'] as List<String>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'description': description,
        'matched_substrings': matchedSubstrings,
        'place_id': placeId,
        'reference': reference,
        'structured_formatting': structuredFormatting?.toJson(),
        'terms': terms?.map((e) => e.toJson()).toList(),
        'types': types,
      };
}
 // create method for sum to numbers
 

