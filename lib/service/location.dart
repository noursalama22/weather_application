import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
// رجوع لجزئية عدم السماح************************
class LocationService {
  late double lat;
  late double long;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await _getLocation();
      lat = position.latitude;
      long = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    // try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
       serviceEnabled =await  Location().requestService();
      }
    // } catch (e) {
    //   print(e);
    //   serviceEnabled = false; 
    //   // TODO:
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
   
    return await Geolocator.getCurrentPosition();
  }
}
