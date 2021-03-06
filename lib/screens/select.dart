import 'package:flutter/material.dart';
import '../models/station.dart';
import '../screens/second.dart';

class Selecting extends StatelessWidget {
  final List<Station> stations = [
    Station(
        name: 'BBC World Service',
        source: 'http://stream.live.vc.bbcmedia.co.uk/bbc_world_service',
        logo: 'assets/images/bbc.png'),
    Station(
        name: 'WNYC 93.9',
        source: 'http://fm939.wnyc.org/wnycfm',
        logo: 'assets/images/wnyc.png')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: ListView.builder(
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
                                builder: (context) => Second(),
                                settings: RouteSettings(
                                    arguments: stations[index].source)),
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
            )
          ],
        ));
  }
}
