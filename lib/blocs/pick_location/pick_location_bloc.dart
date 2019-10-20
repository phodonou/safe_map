import 'package:bloc/bloc.dart';
import 'pick_location_event.dart';
import 'pick_location_state.dart';
import 'package:demon_hacks/repos/repos.dart';
import 'package:meta/meta.dart';

import 'package:demon_hacks/mock_data.dart';
import 'package:demon_hacks/models/models.dart';

class PickLocationBloc extends Bloc<PickLocationEvent, PickLocationState> {
  final HeatMapRepo heatMapRepo;
  PickLocationBloc({@required this.heatMapRepo});
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
      yield LocationFetching();
      // List<HeatMapItem> heatMapItems = await heatMapRepo.fetchHeatMapItems(
      //   locationSearchResult: event.locationSearchResult,
      // );
      await Future.delayed(Duration(seconds: 1));
      yield LocationFetched(
        centeredLocation: mockCenteredLocation,
        heatMapItems: mockHeapMapItems,
      );
    }
  }
}
