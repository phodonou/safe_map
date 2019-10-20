import 'package:meta/meta.dart';

class FeedItem {
  final String message;
  final String date;
  final String name;
  final int favoriteCount;
  FeedItem({
    @required this.message,
    @required this.date,
    @required this.name,
    @required this.favoriteCount,
  });
}
