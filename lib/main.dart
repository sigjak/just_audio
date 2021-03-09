import 'package:JustAudio/screens/js.dart';
import 'package:JustAudio/screens/select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/helpers/data_provider.dart';

import './screens/select.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => DataProvider(),
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light, primaryColor: Color(0xFF9E9E9E)),
        home: Selecting(),
      ),
    );
  }
}
