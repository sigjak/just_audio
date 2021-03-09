import 'package:JustAudio/screens/helpers/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import '../../models/station.dart';

class DataProvider with ChangeNotifier {
  AudioPlayer _audioPlayer;
  List<Station> stations = [
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

  // Future<void> setSource(int index) async {
  //   AudioSource radioStation = AudioSource.uri(
  //     Uri.parse(stations[index].source),
  //     tag: AudioMetadata(
  //         album: stations[index].name,
  //         title: '',
  //         artwork: stations[index].logo),
  //   );
  //   await _audioPlayer.setAudioSource(radioStation);
  // }
}
