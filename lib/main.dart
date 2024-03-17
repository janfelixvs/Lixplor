import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lixplor/spotify_auth.dart';
//import 'package:lixplor/spotify_auth.dart';
import 'package:lixplor/env/env.dart';

Future<void> main() async {
  String clientID = Env.clientId;
  String secretKey = Env.secretKey;

  if (kDebugMode) {
    print(clientID);
  }
  if (kDebugMode) {
    print(secretKey);
  }
  var token = await getToken(clientID, secretKey);

  var aristName = "Aurora";
  try {
    var artist = await searchForArtist(token, aristName);
    if (kDebugMode) {
      print('Artist: $artist');
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
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

class _FoundArtistState extends State<MyHomePage> {
  String foundArtist = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
