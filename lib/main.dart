import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multibiomegame/maps/map1.dart';

final tileSize = 32.0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.util.setLandscape(); //TODO Comment when running for web
    await Flame.util.fullScreen(); //TODO Comment when running for web
  }
  runApp(MyApp());
}

enum ShowInEnum {
  left,
  right,
  top,
  bottom,
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonfire Multi Biome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Map1(),
    );
  }
}
