import 'package:flutter/material.dart';
import '../models/station.dart';

import '../screens/player.dart';

class Selecting extends StatelessWidget {
  final List<Station> stations = [
    Station(
        name: 'BBC World Service',
        source: 'http://stream.live.vc.bbcmedia.co.uk/bbc_world_service',
        logo: 'assets/images/bbc.png'),
    Station(
        name: 'WNYC 93.9',
        source: 'http://fm939.wnyc.org/wnycfm',
        logo: 'assets/images/wnyc.png'),
    Station(
        name: 'RUV Rás 1',
        source: 'http://netradio.ruv.is/ras1.mp3',
        logo: 'assets/images/ras_1.png'),
    Station(
        name: 'RUV Rás 2',
        source: 'http://netradio.ruv.is/ras2.mp3',
        logo: 'assets/images/ras_2.png'),
    Station(
        name: 'WAMU',
        source: 'http://wamu-1.streamguys.com',
        logo: 'assets/images/wamu.png'),
    Station(
        name: 'WBUR',
        source: 'https://icecast-stream.wbur.org/wbur',
        logo: 'assets/images/wbur.png'),
    Station(
        name: 'Bylgjan',
        source: 'http://stream3.radio.is:443/tbylgjan',
        logo: 'assets/images/bylgjan.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.only(top: 16),
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black12,
            border: Border.all(color: Colors.black),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 12,
                child: Text(
                  'Radio',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: stations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          print(stations[index].source);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Player(stations, index),
                            ),
                          );
                        },
                        child: Image(
                          height: 100,
                          width: 100,
                          image: AssetImage(stations[index].logo),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
