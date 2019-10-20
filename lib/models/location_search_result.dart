import 'package:meta/meta.dart';
import 'coordinates.dart';

class LocationSearchResult {
  final String locationName;
  final Coordinates coordinates;

  LocationSearchResult({
    @required this.locationName,
    @required this.coordinates
  });  
}