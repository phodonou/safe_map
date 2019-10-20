import 'package:bloc/bloc.dart';
import 'pick_location_event.dart';
import 'pick_location_state.dart';

import 'package:demon_hacks/models/models.dart';

class PickLocationBloc extends Bloc<PickLocationEvent, PickLocationState> {
  final centeredLocation = LocationSearchResult(
    coordinates: Coordinates(
      lat: 37.42796133580664,
      long: -122.085749655962,
    ),
    locationName: 'Initial',
  );
  @override
  PickLocationState get initialState => LocationFetched(
        centeredLocation: centeredLocation,
        heatMapItems: [
          HeatMapItem(
            id: '1',
            details: '',
            itemName: 'California',
            dangerNumber: 1,
            coordinates: Coordinates(
              lat: 37.42796133580664,
              long: -130.085749655962,
            ),
          )
        ],
      );

  @override
  Stream<PickLocationState> mapEventToState(
    PickLocationEvent event,
  ) async* {
    if (event is LocationPicked) {}
  }
}
