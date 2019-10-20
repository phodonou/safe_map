import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:demon_hacks/network/http_service.dart';
import 'package:demon_hacks/models/models.dart';
import 'package:http/http.dart';

class LocationSearchRepo {
  final HttpService httpService;
  LocationSearchRepo({
    @required this.httpService,
  });

  Future<List<LocationSearchResult>> fetchLocationSearchResults(
      String locationString) async {
    List<LocationSearchResult> result = [];
    Response res = await httpService.createGetRequest(
        authority: 'maps.googleapis.com',
        path: '/maps/api/place/findplacefromtext/json',
        queryParameters: {
          'input': locationString,
          'inputtype': 'textquery',
          'fields': 'name,geometry,formatted_address',
          'key': 'AIzaSyAPf4j1wGC3A_eqOl7ThYZcydtUe8vAbrM'
        });
    try {
      List candidates = jsonDecode(res.body)['candidates'];
      for (var object in candidates) {
        result.add(
          LocationSearchResult(
            coordinates: Coordinates(
              lat: object['geometry']['location']['lat'],
              long: object['geometry']['location']['lng'],
            ),
            locationName: object['name'],
            address: object['formatted_address'],
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
