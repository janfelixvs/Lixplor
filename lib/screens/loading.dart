import 'package:flutter/material.dart';
import 'package:lixplor/connection/spotify_auth.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  SpotifyAuth auth = SpotifyAuth();

  @override
  void initState() {
    super.initState();
    auth.getToken();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
