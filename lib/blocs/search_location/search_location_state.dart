import 'package:meta/meta.dart';
import 'package:demon_hacks/models/models.dart';

abstract class SearchLocationState {}

class LocationSearchResults extends SearchLocationState {
  final List<LocationSearchResult> locationSearchResults;
  LocationSearchResults({
    @required this.locationSearchResults,
  });
}

class LocationSearching extends SearchLocationState {}