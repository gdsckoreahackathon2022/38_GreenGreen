import 'package:geolocator/geolocator.dart';

class LocationRepository {
  getPermission() async {
    var permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("안하면 못씀...");
      }
    }
  }

  Future<List<double>> getCurrentLocation() async {
    Position postion = await Geolocator.getCurrentPosition();
    return [postion.latitude, postion.longitude];
  }
}
