import 'package:meta/meta.dart';
import 'package:http/http.dart';

class HttpService {
  Future<Response> createGetRequest({
    @required String authority,
    @required String path,
    @required Map<String, String> queryParameters,
  }) async {
    try {
      Uri uri = Uri.https(authority, path, queryParameters);
      Response res =  await get(uri);
      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }
}