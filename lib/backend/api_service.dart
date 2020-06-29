import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_api_example/model/quote.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

// class APIService {
//   final API api;
//   const APIService(this.api);

//   Future<List<Quote>> getEndpointData({@required Endpoint endpoint}) async {
//     final Uri uri = api.endpointUri(endpoint);
//

//       if (endpoint == Endpoint.all) {
//         final cache = DefaultCacheManager();
//         final response = await cache.getSingleFile(uri.toString());
//         if (response != null) {
//           final parse = await json.decode(await response.readAsString());

//           final data = parse as List;
//           final map = data.map<Quote>((json) => Quote.fromJson(json));

//           return map.toList();
//         }
//       }
//       if (endpoint == Endpoint.random) {
//         try {
//           final response = await http.get(uri.toString());
//           final parse = await json.decode(response.body);
//           final randomQuote = List.of([Quote.fromJson(parse as Map)]);
//           print(randomQuote[0]);
//           return randomQuote;
//         } catch (error) {
//           throw error;
//         }
//       }

//   }
// }

class APIService {
  const APIService(this.api);
  final API api;

  Future<List<Quote>> getEndpointData({@required Endpoint endpoint}) async {
    Uri uri = api.endpointUri(endpoint);

    if (endpoint == Endpoint.all) {
      final cache = DefaultCacheManager();
      final response = await cache.getSingleFile(uri.toString());

      if (response != null) {
        final parsedFile = json.decode(await response.readAsString());

        final data = parsedFile as List;

        final map = data.map((json) => Quote.fromJson(json));

        return map.toList();
      }

      throw response;
    }

    if (endpoint == Endpoint.random) {
      try {
        final response = await http.get(uri.toString());
        final parsedJson = json.decode(response.body);
        final map = Quote.fromJson(parsedJson);

        return List.from([map]);
      } catch (error) {
        throw error;
      }
    }
  }
}
