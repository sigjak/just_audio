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
  List<String> audioFiles = [];
  List<AudioSource> myList = [
    AudioSource.uri(Uri.parse("asset:///audio/book/guard.mp3"),
        tag: AudioMetadata(album: 'Grisham: The Guardians')),
  ];
  List<AudioSource> workList = [];
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    getAssetFiles().then((_) {
      _audioPlayer
          .setAudioSource(ConcatenatingAudioSource(children: workList))
          .catchError((error) {
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
      //String temp = element.replaceAll('%20', ' ');

      workList.add(AudioSource.uri(Uri.parse("asset:///$element"),
          tag: AudioMetadata(album: "Grisham; The Guardians", title: element)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ElevatedButton(
          //     onPressed: () async {
          //       // await getAssetFiles();
          //       print(workList);
          //     },
          //     child: null),
          StreamBuilder<SequenceState>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (_, snapshot) {
                final state = snapshot.data;
                // if (state?.sequence?.isEmpty ?? true) return SizedBox();
                return state != null
                    ? Column(children: [
                        Text(state.sequence[0].tag.album),
                        Text(state.sequence[state.currentIndex].tag.title)
                      ])
                    : Text('');
              }),
          PlayerButtons(_audioPlayer),
          SliderBar(_audioPlayer),
        ],
      ),
    ));
  }
}
