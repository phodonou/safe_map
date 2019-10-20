import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'search_location_event.dart';
import 'search_location_state.dart';
import 'package:demon_hacks/models/models.dart';
import 'package:demon_hacks/repos/repos.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  final LocationSearchRepo locationSearchRepo;

  SearchLocationBloc({@required this.locationSearchRepo});

  @override
  SearchLocationState get initialState => LocationSearchResults(
        locationSearchResults: [],
      );

  @override
  Stream<SearchLocationState> mapEventToState(
    SearchLocationEvent event,
  ) async* {
    if (event is LocationInputed) {
      yield LocationSearching();
      List<LocationSearchResult> locationSearchResults =
          await locationSearchRepo.fetchLocationSearchResults(event.location);
      yield LocationSearchResults(
        locationSearchResults: locationSearchResults,
      );
    }
  }
}
