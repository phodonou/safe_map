import 'package:bloc/bloc.dart';
import 'feeds_event.dart';
import 'feeds_state.dart';

import 'package:demon_hacks/repos/repos.dart';
import 'package:meta/meta.dart';
import 'package:demon_hacks/models/models.dart';

class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  final FeedsRepo feedsRepo;
  FeedsBloc({@required this.feedsRepo});

  @override
  FeedsState get initialState => FeedsFetched(feedItems: []);

  @override
  Stream<FeedsState> mapEventToState(
    FeedsEvent event,
  ) async* {
    if (event is RetrieveFeeds) {
      yield FetchingFeeds();
      List<FeedItem> feedItems = await feedsRepo.fetchFeeds(
        locationSearchResult: event.locationSearchResult,
      );
      yield FeedsFetched(feedItems: feedItems);
    }
  }
}
