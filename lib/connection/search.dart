import 'package:flutter/foundation.dart';
import 'package:lixplor/connection/spotify_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Search {
  Future<List?> searchForArtist(
      SpotifyAuth auth, String artistName, int length) async {
    var url = Uri.parse("${auth.baseURL}/search");
    var headers = auth.getAuthHeader();

    var queryParameters = {
      "q": artistName,
      "type": "artist",
      "limit": "$length",
    };

    var response = await http.get(url.replace(queryParameters: queryParameters),
        headers: headers);

    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['artists']['items'] as List;
      if (jsonResult.isEmpty) {
        if (kDebugMode) {
          print('No artist found with this name');
        }
        return null;
      }
      return jsonResult;
    } else {
      throw Exception('Failed to load artist');
    }
  }
}
