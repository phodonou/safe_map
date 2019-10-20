import 'package:meta/meta.dart';
import 'coordinates.dart';

class LocationSearchResult {
  final String locationName;
  final String address;
  final Coordinates coordinates;

  LocationSearchResult({
    @required this.locationName,
    @required this.address,
    @required this.coordinates
  });  
}