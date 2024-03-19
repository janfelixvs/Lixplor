import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lixplor/env/env.dart';

class SpotifyAuth {
  String clientID;
  String secretKey;
  String token;
  late DateTime createTime;

  String baseURL = "https://api.spotify.com/v1/";

  SpotifyAuth()
      : clientID = Env.clientId,
        secretKey = Env.secretKey,
        token = "";

  Map<String, String> getAuthHeader() {
    return {"Authorization": "Bearer $token"};
  }

  Future<void> getToken() async {
    if (token.isEmpty || DateTime.now().difference(createTime).inHours > 12) {
      var authString = "$clientID:$secretKey";
      var authBytes = utf8.encode(authString);
      var authBase64 = base64Encode(authBytes);

      var url = "https://accounts.spotify.com/api/token";

      var headers = {
        "Authorization": "Basic $authBase64",
        "Content-Type": "application/x-www-form-urlencoded"
      };

      var data = {"grant_type": "client_credentials"};

      var response =
          await http.post(Uri.parse(url), headers: headers, body: data);

      if (response.statusCode == 200) {
        var jsonResult = jsonDecode(response.body);
        token = jsonResult["access_token"];
        createTime = DateTime.now();
      } else {
        throw Exception('Failed to load token');
      }
    }
    if (kDebugMode) {
      print(token);
    }
  }
}
