library validate_location;

import 'package:geolocator/geolocator.dart';

Map<String, dynamic> isValidLocation({
  required String lang,
  required String long,
  required List<Map<String, dynamic>> stations,
}) {
  late String tempLang = '';
  late String tempLong = '';
  late String tempStation = '';
  bool isValidate = false;

  for (int i = 0; i < stations.length; i++) {
    for (int k = 0; k < stations[i]['location'].length; k++) {
      if ((lang.contains(stations[i]['location'][k]['lang'])) &&
          (long.contains(stations[i]['location'][k]['long']))) {
        tempLang = stations[i]['location'][k]['lang'];
        tempLong = stations[i]['location'][k]['long'];
        tempStation = stations[i]['name'];
        isValidate = true;
        break;
      } else {
        continue;
      }
    }
    if (!(tempLang == '' && tempLong == '')) {
      break;
    }
  }
  return {
    'validate': isValidate,
    'lang': tempLang,
    'long': tempLong,
    'station': tempStation,
  };
}

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
