import 'package:meta/meta.dart';

abstract class SearchLocationEvent {}

class LocationInputed extends SearchLocationEvent {
  final String location;
  LocationInputed({
    @required this.location,
  });
}