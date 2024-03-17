import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lixplor/env/env.dart';

Future<String> getToken(String clientId, String clientSecret) async {
  var authString = "$clientId:$clientSecret";
  var authBytes = utf8.encode(authString);
  var authBase64 = base64Encode(authBytes);

  var url = "https://accounts.spotify.com/api/token";

  var headers = {
    "Authorization": "Basic $authBase64",
    "Content-Type": "application/x-www-form-urlencoded"
  };

  var data = {"grant_type": "client_credentials"};

  var response = await http.post(Uri.parse(url), headers: headers, body: data);

  if (response.statusCode == 200) {
    var jsonResult = jsonDecode(response.body);
    var token = jsonResult["access_token"];
    return token;
  } else {
    throw Exception('Failed to load token');
  }
}

Map<String, String> getAuthHeader(String token) {
  return {"Authorization": "Bearer $token"};
}

Future<Map<String, dynamic>?> searchForArtist(
    String token, String artistName) async {
  var url = Uri.parse('https://api.spotify.com/v1/search');
  var headers = getAuthHeader(token);

  var queryParameters = {
    "q": artistName,
    "type": "artist",
    "limit": "1",
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
    return jsonResult[0] as Map<String, dynamic>;
  } else {
    throw Exception('Failed to load artist');
  }
}

Future<void> searchArtist(String text) async {
  String clientID = Env.clientId;
  String secretKey = Env.secretKey;
  var token = await getToken(clientID, secretKey);
  try {
    var artist = await searchForArtist(token, text);
    if (kDebugMode) {
      print('Artist: $artist');
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
