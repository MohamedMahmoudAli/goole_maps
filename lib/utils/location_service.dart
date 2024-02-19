import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<bool> checkAndRequestLocationService() async {
    var isServicedEnabled = await location.serviceEnabled();
    if (!isServicedEnabled) {
      isServicedEnabled = await location.requestService();
      if (!isServicedEnabled) {
        return false;
      }
    }
    checkAndRequestLocationPremission();
    return true;
  }

  Future<bool> checkAndRequestLocationPremission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }
    return true;
  }

  getRealTimeLocation(Function(LocationData)? onData) {
    location.onLocationChanged.listen(onData);
  }
}
