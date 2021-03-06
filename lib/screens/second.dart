import 'package:flutter/material.dart';
//import '../models/station.dart';

class Second extends StatefulWidget {
  //final String station;
  // const Second(this.station);
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  String station;
  String mine = 'bla';
  initMine() {
    setState(() {
      mine = station;
    });
  }

  @override
  void initState() {
    mine = 'bobob';
    print('initstate');

    super.initState();
  }

  @override
  void didChangeDependencies() {
    mine = 'station';
    print('didchange');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    station = ModalRoute.of(context).settings.arguments;
    //initMine();
    print('before Scaffold');
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(station),
          Text(mine),
        ],
      ),
    );
  }
}
