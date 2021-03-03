import 'package:flutter/material.dart';
import './screens/player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: Color(0xFF9E9E9E)),
      home: Player(),
    );
  }
}
