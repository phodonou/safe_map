import 'package:demon_hacks/models/models.dart';
import 'package:meta/meta.dart';

abstract class FeedsState {}

class FeedsFetched extends FeedsState {
  final List<FeedItem> feedItems;
   FeedsFetched({
     @required this.feedItems
   });
}

class FetchingFeeds extends FeedsState {}