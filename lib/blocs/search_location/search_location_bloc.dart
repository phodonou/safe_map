import 'package:bloc/bloc.dart';

import 'search_location_event.dart';
import 'search_location_state.dart';
import 'package:demon_hacks/models/models.dart';

import 'package:demon_hacks/mock_data.dart';

class SearchLocationBloc extends Bloc<SearchLocationEvent, SearchLocationState> {
  @override
  SearchLocationState get initialState => LocationSearchResults(
        locationSearchResults: [],
      );

  @override
  Stream<SearchLocationState> mapEventToState(
    SearchLocationEvent event,
  ) async* {
    if(event is LocationInputed) {
      yield LocationSearching();
      await Future.delayed(Duration(seconds: 1));
      yield LocationSearchResults(
        locationSearchResults: mockLocationSearchResult,
      );
    }
  }
}
