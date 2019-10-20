import 'models/models.dart';

final mockCenteredLocation = LocationSearchResult(
  coordinates: Coordinates(
    lat: 37,
    long: -122,
  ),
  locationName: 'Initial',
);

final List<LocationSearchResult> mockLocationSearchResult = [
  LocationSearchResult(
      locationName: 'Result 1',
      coordinates: Coordinates(
        lat: 1.0,
        long: 1.0,
      )),
  LocationSearchResult(
      locationName: 'Result 1',
      coordinates: Coordinates(
        lat: 1.0,
        long: 1.0,
      )),
  LocationSearchResult(
    locationName: 'Result 1',
    coordinates: Coordinates(
      lat: 1.0,
      long: 1.0,
    ),
  ),
  LocationSearchResult(
      locationName: 'Result 1',
      coordinates: Coordinates(
        lat: 1.0,
        long: 1.0,
      )),
  LocationSearchResult(
      locationName: 'Result 1',
      coordinates: Coordinates(
        lat: 1.0,
        long: 1.0,
      ))
];

final List<HeatMapItem> mockHeapMapItems = [
  HeatMapItem(
    id: '1',
    details: '',
    itemName: 'California',
    dangerNumber: 1,
    coordinates: Coordinates(
      lat: 37,
      long: -122,
    ),
  ),
  HeatMapItem(
    id: '1',
    details: '',
    itemName: 'California',
    dangerNumber: 1,
    coordinates: Coordinates(
      lat: 37.001,
      long: -122.001,
    ),
  ),
  // HeatMapItem(
  //   id: '1',
  //   details: '',
  //   itemName: 'California',
  //   dangerNumber: 1,
  //   coordinates: Coordinates(
  //     lat: 37.42796133580664,
  //     long: -122.085749655962,
  //   ),
  // ),HeatMapItem(
  //   id: '1',
  //   details: '',
  //   itemName: 'California',
  //   dangerNumber: 1,
  //   coordinates: Coordinates(
  //     lat: 37.42796133580664,
  //     long: -122.085749655962,
  //   ),
  // )
];
