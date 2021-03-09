import 'package:flutter/material.dart';
import '../models/station.dart';

class Second extends StatefulWidget {
  final Station stations;
  const Second(this.stations);
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  String station;
  String mine = 'bla';
  @override
  void initState() {
    mine = widget.stations.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('before Scaffold');
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(widget.stations.source),
          Text(mine),
        ],
      ),
    );
  }
}
