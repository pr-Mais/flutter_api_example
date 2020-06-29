import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_api_example/model/quote.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class APIService {
  const APIService(this.api);
  final API api;

  Future<List<Quote>> getEndpointData({@required Endpoint endpoint}) async {
    Uri uri = api.endpointUri(endpoint);

    final response = await http.get(uri.toString());
    
    if (response != null) {

      final parsedJson = json.decode(response.body);
      
      if (endpoint == Endpoint.all) {
        final map =
            List<Quote>.from(parsedJson.map((json) => Quote.fromJson(json)));
        return map;
      }
      if (endpoint == Endpoint.random) {
        final map = List<Quote>.from([Quote.fromJson(parsedJson)]);

        return map;
      }
    }

    throw response;
  }
}
