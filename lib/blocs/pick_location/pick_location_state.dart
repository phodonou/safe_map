import 'package:meta/meta.dart';
import 'package:demon_hacks/models/models.dart';

abstract class PickLocationState {}

class LocationFetched extends PickLocationState {
  final LocationSearchResult centeredLocation;
  final List<HeatMapItem> heatMapItems;
  LocationFetched({
    @required this.centeredLocation,
    @required this.heatMapItems,
  });
}

class LocationFetching extends PickLocationState {}
