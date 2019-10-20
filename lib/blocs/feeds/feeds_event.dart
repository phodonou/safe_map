import 'package:demon_hacks/models/models.dart';
import 'package:meta/meta.dart';

abstract class FeedsEvent {}

class RetrieveFeeds extends FeedsEvent {
  final LocationSearchResult locationSearchResult;
   RetrieveFeeds({
     @required this.locationSearchResult
   });
}