import 'dart:convert';

import 'keys.dart';

class SpotifyAuth {
  late String authString;
  late List<int> authBytes;
  late String authBase64;
  String url = "https://accounts.spotify.com/api/token";
  late Map<String, String> headers;

  SpotifyAuth() {
    authString = "${Keys.apiKey}:${Keys.secretKey}";
    authBytes = utf8.encode(authString);
    authBase64 = base64Encode(authBytes);
    headers = {
      "Authorization": "Basic $authBase64",
      "Content-Type": "application/x-www-form-urlencoded"
    };
  }
}
