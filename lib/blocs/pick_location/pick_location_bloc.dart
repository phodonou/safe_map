import 'package:bloc/bloc.dart';
import 'pick_location_event.dart';
import 'pick_location_state.dart';

import 'package:demon_hacks/models/models.dart';
import 'package:demon_hacks/mock_data.dart';

class PickLocationBloc extends Bloc<PickLocationEvent, PickLocationState> {
  
  @override
  PickLocationState get initialState => LocationFetched(
        centeredLocation: mockCenteredLocation,
        heatMapItems: mockHeapMapItems,
      );

  @override
  Stream<PickLocationState> mapEventToState(
    PickLocationEvent event,
  ) async* {
    if (event is LocationPicked) {
      print('LOCATION PICKED');
    }
  }
}
