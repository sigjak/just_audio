import 'dart:convert';
import '../models/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import './commons/player_buttons.dart';
import './commons/slider.dart';
import '../screens/helpers/meta.dart';
import 'package:provider/provider.dart';
import './helpers/data_provider.dart';

class Player extends StatefulWidget {
  final int index;
  const Player(this.index);
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  AudioPlayer _audioPlayer;
  // ConcatenatingAudioSource _playList;
  List<AudioSource> workList = [];
  List<String> audioFiles = [];
  bool isRadio = false;
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    initRadio(widget.index);
    // final data = Provider.of<DataProvider>(context, listen: false);
    // _audioPlayer = AudioPlayer();
    // AudioSource radio = AudioSource.uri(
    //   Uri.parse(data.stations[widget.index].source),
    //   tag: AudioMetadata(
    //       album: data.stations[widget.index].name,
    //       title: data.stations[widget.index].name,
    //       artwork: data.stations[widget.index].logo),
    // );
    // _audioPlayer.setAudioSource(radio);

    // getAssetFiles().then((_) {
    //   _audioPlayer.setAudioSource(_playList).catchError((error) {
    //     // catch load errors: 404, invalid url ...
    //     print("An error occured $error");
    //   });
    // });
  }

  // Future<void> _init() async {
  //   final session = await AudioSession.instance;
  //   await session.configure(AudioSessionConfiguration.speech());
  //   try {
  //     await _player.setAudioSource(_playlist);
  //   } catch (e) {
  //     // catch load errors: 404, invalid url ...
  //     print("An error occured $e");
  //   }
  // }

  initRadio(index) async {
    print('INIT  ------------------------            $index');
    final data = Provider.of<DataProvider>(context, listen: false);
    // _audioPlayer = AudioPlayer();
    AudioSource radio = AudioSource.uri(
      Uri.parse(data.stations[index].source),
      tag: AudioMetadata(
          album: data.stations[index].name,
          title: data.stations[index].name,
          artwork: data.stations[index].logo),
    );
    await _audioPlayer.setAudioSource(radio);
    setState(() {});
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
    print('dispose');
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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[400],
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
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            height: 200,
                            child: Image(
                              image: AssetImage(state.sequence[0].tag.artwork),
                            ),
                          ),
                          Text(state.sequence[0].tag.album,
                              style: TextStyle(fontSize: 20)),
                          Text(state.sequence[state.currentIndex].tag.title)
                        ])
                      : Text('');
                }),
            PlayerButtons(_audioPlayer),
            SliderBar(_audioPlayer),
            SizedBox(
              height: 5,
            ),
            isRadio
                ? SizedBox()
                : Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Episodes',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.stations.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return Card(
                                margin: EdgeInsets.fromLTRB(16, 2, 16, 0),
                                child: ListTile(
                                  //leading: Image( AssetImage(widget.stations[index].logo),
                                  title: Text(data.stations[index].name),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await _audioPlayer.stop();
                                      initRadio(index);
                                    },
                                    // onPressed: () async {
                                    //   await _audioPlayer
                                    //       .setAudioSource(_playList);
                                    //   //
                                    //   _audioPlayer.seek(Duration(seconds: 12),
                                    //       index: index);
                                    //   _audioPlayer.play();
                                    // },
                                    icon: Icon(Icons.play_arrow),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
