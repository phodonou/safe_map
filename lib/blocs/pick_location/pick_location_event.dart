import 'package:demon_hacks/models/models.dart';
import 'package:meta/meta.dart';

abstract class PickLocationEvent {}

class LocationPicked{
  final LocationSearchResult locationSearchResult;
  LocationPicked({
    @required this.locationSearchResult,
  });
}
  

