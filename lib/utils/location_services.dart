import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<void> checkAndRequestLocationService() async {
    var isServicedEnabled = await location.serviceEnabled();
    if (!isServicedEnabled) {
      isServicedEnabled = await location.requestService();
      if (!isServicedEnabled) {
        throw LocationPermissionException;
      }
    }
    checkAndRequestLocationPremission();
  }

  Future<void> checkAndRequestLocationPremission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw LocationPermissionException;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        throw LocationPermissionException;
      }
    }
  }

  getRealTimeLocation(Function(LocationData)? onData) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPremission();
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getCurrentLocation() async {
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
