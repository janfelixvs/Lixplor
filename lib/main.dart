import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lixplor/connection/search.dart';
import 'package:lixplor/connection/spotify_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lixplor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Please insert the artist name here:'),
            TextField(
              controller: _controller,
            ),
            ElevatedButton(
              onPressed: () async {
                if (kDebugMode) {
                  SpotifyAuth a = SpotifyAuth();
                  await a.getToken();
                  print(a.token);
                  //var test = Search().searchForArtist(a, _controller.text, 1);
                  //print(test);
                }
              },
              child: const Text('Search'),
            )
          ],
        ),
      ),
    );
  }
}
