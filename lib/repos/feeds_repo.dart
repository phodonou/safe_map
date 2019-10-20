import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart';

import 'package:demon_hacks/network/http_service.dart';
import 'package:demon_hacks/models/models.dart';


class FeedsRepo {
  final HttpService httpService;
  FeedsRepo({
    @required this.httpService
  });

  Future<List<FeedItem>> fetchFeeds({
    @required LocationSearchResult locationSearchResult,
  })async{
    List<FeedItem> feedItems = [];
    Response res = await httpService.createGetRequest(
      authority: 'stay-safe-today.herokuapp.com',
      path: '/danger_feed',
      queryParameters: {
        'lat': locationSearchResult.coordinates.lat.toString(),
        'lon': locationSearchResult.coordinates.long.toString(),
      },
    );
    try {
      List crimes = jsonDecode(res.body)['crimes'];
      for(var crime in crimes){
        feedItems.add(FeedItem(
          message: crime['message'],
          date: crime['date'],
          name: crime['name'],
          favoriteCount: crime['favorite_count'],
        ));
      }
    } catch (e) {
      print(e);
    }
    return feedItems;
  }

}