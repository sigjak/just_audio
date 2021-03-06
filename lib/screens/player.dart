import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import './commons/player_buttons.dart';
import './commons/slider.dart';
import '../screens/helpers/meta.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  AudioPlayer _audioPlayer;
  ConcatenatingAudioSource _playList;
  List<AudioSource> workList = [];
  List<String> audioFiles = [];
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    getAssetFiles().then((_) {
      _audioPlayer.setAudioSource(_playList).catchError((error) {
        // catch load errors: 404, invalid url ...
        print("An error occured $error");
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> getAssetFiles() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);

    List<String> assetFiles =
        manifestMap.keys.where((key) => key.contains('.mp3')).toList();
    assetFiles.forEach((element) {
      String temp = element.replaceAll('%20', ' ');
      String fileName = temp.substring(11);
      audioFiles.add(fileName);
      workList.add(
        AudioSource.uri(
          Uri.parse("asset:///$temp"),
          tag: AudioMetadata(
              album: "Grisham: The Guardians",
              title: fileName,
              artwork: "assets/images/guardians.jpg"),
        ),
      );
    });
    _playList = ConcatenatingAudioSource(children: [
      // AudioSource.uri(
      //   //mp3: http://fm939.wnyc.org/wnycfm
      //   Uri.parse("http://am820.wnyc.org/wnycam"),
      //   tag: AudioMetadata(
      //     album: "Science Friday",
      //     title: "WNYC AM820",
      //   ),
      // ),
      // AudioSource.uri(
      //   Uri.parse("http://fm939.wnyc.org/wnycfm"),
      //   tag: AudioMetadata(
      //     album: "Science Friday",
      //     title: "WNYC AM820",
      //   ),
      // ),
      // AudioSource.uri(
      //   Uri.parse("http://bbcwssc.ic.llnwd.net/stream/bbcwssc_mp1_ws-einws"),
      //   tag: AudioMetadata(
      //     album: "Science Friday",
      //     title: "WNYC AM820",
      //   ),
      // ),
      //       AudioSource.uri(
      //   Uri.parse(
      //       "http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/nonuk/sbr_vlow/llnw/bbc_world_service.m3u8"),
      //   tag: AudioMetadata(
      //     album: "Science Friday",
      //     title: "WNYC AM820",
      //   ),
      // ),
      AudioSource.uri(
        Uri.parse("http://stream.live.vc.bbcmedia.co.uk/bbc_world_service"),
        tag: AudioMetadata(
          album: "Science Friday",
          title: "WNYC AM820",
        ),
      ),
    ]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(title: Text('Audioplayer')),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<SequenceState>(
                stream: _audioPlayer.sequenceStateStream,
                builder: (_, snapshot) {
                  final state = snapshot.data;

                  return state != null
                      ? Column(children: [
                          // Container(
                          //   margin: EdgeInsets.symmetric(vertical: 20),
                          //   height: 200,
                          //   child: Image(
                          //     image: AssetImage(state.sequence[0].tag.artwork),
                          //   ),
                          // ),
                          Text(state.sequence[0].tag.album,
                              style: TextStyle(fontSize: 20)),
                          Text(state.sequence[state.currentIndex].tag.title)
                        ])
                      : Text('');
                }),
            PlayerButtons(_audioPlayer),
            SliderBar(_audioPlayer),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                'Episodes',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: audioFiles.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Card(
                    margin: EdgeInsets.fromLTRB(16, 2, 16, 0),
                    child: ListTile(
                      title: Text(audioFiles[index]),
                      trailing: IconButton(
                        onPressed: () async {
                          await _audioPlayer.setAudioSource(_playList);
                          //
                          _audioPlayer.seek(Duration(seconds: 12),
                              index: index);
                          _audioPlayer.play();
                        },
                        icon: Icon(Icons.play_arrow),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
