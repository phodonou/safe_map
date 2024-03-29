import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart';

import 'package:demon_hacks/network/http_service.dart';
import 'package:demon_hacks/models/models.dart';

class HeatMapRepo {
  final HttpService httpService;
  HeatMapRepo({
    @required this.httpService,
  });
  Future<List<HeatMapItem>> fetchHeatMapItems({
    @required LocationSearchResult locationSearchResult,
  }) async {
    List<HeatMapItem> heatMapItems = [];
    Response res = await httpService.createGetRequest(
      authority: 'stay-safe-today.herokuapp.com',
      path: '/danger_locations',
      queryParameters: {
        'lat': locationSearchResult.coordinates.lat.toString(),
        'lon': locationSearchResult.coordinates.long.toString(),
      },
    );
    try {
      List crimes = jsonDecode(res.body)['crimes'];
      for(var crime in crimes.sublist(0, 500)){
        heatMapItems.add(
          HeatMapItem(
            id: "${crime['lat']}${crime['lon']}",
            coordinates: Coordinates(
              lat: crime['lat'],
              long: crime['lon'],
            ),
            details: crime['crime']
          )
        );
      }
    } catch (e) {
      print(e);
    }
    return heatMapItems;
  }
}
