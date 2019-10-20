import 'package:bloc/bloc.dart';
import 'pick_location_event.dart';
import 'pick_location_state.dart';
import 'package:demon_hacks/repos/repos.dart';
import 'package:meta/meta.dart';

import 'package:demon_hacks/mock_data.dart';
import 'package:demon_hacks/models/models.dart';
import 'package:demon_hacks/blocs/blocs.dart';

class PickLocationBloc extends Bloc<PickLocationEvent, PickLocationState> {
  final HeatMapRepo heatMapRepo;
  final FeedsBloc feedBloc;
  PickLocationBloc({
    @required this.heatMapRepo,
    @required this.feedBloc,
  });
  @override
  PickLocationState get initialState => LocationFetched(
        centeredLocation: mockCenteredLocation,
        heatMapItems: [],
      );

  @override
  Stream<PickLocationState> mapEventToState(
    PickLocationEvent event,
  ) async* {
    if (event is LocationPicked) {
      yield LocationFetching();
      List<HeatMapItem> heatMapItems = await heatMapRepo.fetchHeatMapItems(
        locationSearchResult: event.locationSearchResult,
      );
      print('HEAT MAP LENGTH ${heatMapItems.length}');
      yield LocationFetched(
        centeredLocation: event.locationSearchResult,
        heatMapItems: heatMapItems,
      );
      feedBloc
          .add(RetrieveFeeds(locationSearchResult: event.locationSearchResult));
    }
  }
}
