import 'package:location/location.dart' as loc;

class Location {
  late Coords position;
  final loc.Location location = loc.Location();

  Future<void> getLocation() async {
    location.changeSettings(accuracy: loc.LocationAccuracy.low);

    dynamic locData = await Future.any([
      location.getLocation(),
      Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () => null,
      ),
    ]);

    locData ??= await location.getLocation();

    if (locData?.latitude == null || locData?.longitude == null) {}
    position =
        Coords(latitude: locData.latitude!, longitude: locData.longitude!);
  }
}

class Coords {
  Coords({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}
