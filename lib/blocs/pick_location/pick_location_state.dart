import 'package:meta/meta.dart';
import 'package:demon_hacks/models/models.dart';

abstract class PickLocationState {}

class LocationFetched extends PickLocationState {
  final List<HeatMapItem> heatMapItems;
  LocationFetched({
    @required this.heatMapItems,
  });
}

class LocationFetching extends PickLocationState {}
