import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:media_info/media_info.dart';
import 'package:path_provider/path_provider.dart';

class AudioRecorderScreen extends StatefulWidget {
  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  final recorder = FlutterSoundRecorder();
  final player = AudioPlayer();
  bool isRecording = false;
  bool isPlaying = false;
  bool isPaused = false;
  bool isResumed = false ;
  String currentFilePath = '';
  List<String> recordedFiles = [];
  String currentPlayingFile = ''; // Track the currently playing file

  @override
  void initState() {
    super.initState();
    fetchRecordedFiles();
  }

  @override
  void dispose() {
    recorder.closeRecorder();

    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/recording_${DateTime.now().microsecondsSinceEpoch}.aac';

      await recorder.openRecorder();
      await recorder.startRecorder(toFile: filePath);
      setState(() {
        isRecording = true;
        currentFilePath = filePath;
      });
    } catch (e) {
      print('Recording failed: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      await recorder.stopRecorder();
      setState(() {
        isRecording = false;
        currentFilePath = '';
      });
      fetchRecordedFiles();
    } catch (e) {
      print('Stopping recording failed: $e');
    }
  }

  Future<void> playAudio(String filePath) async {
    if (isPlaying) return;

    try {
      await player.play(DeviceFileSource(filePath));
      setState(() {
        isPlaying = true;
        isResumed = true ;
        currentPlayingFile = filePath;

      });
      player.onPlayerComplete.listen((event) {
        setState(() {
          isPlaying = false;
          isPaused = false ;
          isResumed = false ;
          currentPlayingFile = '';
        });
      });
    } catch (e) {
      print('Playback failed: $e');
    }
  }
  Future<void> pauseAudio() async {
    if (isPlaying) {
      await player.pause();
      setState(() {
        isPlaying = false;
        isPaused = true;
        isResumed = false ;
      });
    }
  }

  Future<void> resumeAudio() async {
      await player.resume();
      setState(() {
        isPlaying = true ;
        isPaused = false;
        isResumed = true;
      });
  }

  Future<void> stopAudio() async {
    await player.stop();
    setState(() {
      isPlaying = false ;
      isPaused = false;
      isResumed = false;
    });
  }


  Future<void> fetchRecordedFiles() async {
    try {

      final directory = await getApplicationDocumentsDirectory();
      final files = await directory.list().toList();

      recordedFiles = files
          .where((file) => file is File && file.path.endsWith('.aac'))
          .map((file) => file.path)
          .toList();

      setState(() {});
    } catch (e) {
      print('Fetching recorded files failed: $e');
    }
  }
  String getFormattedDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
  Future<Duration?> getDuaration (String path)  {
    final audio = AudioPlayer();
    audio.setSourceDeviceFile(path) ;
    print (audio.getDuration()) ;
    return audio.getDuration() ;
  }

  Widget buildRecordItem(String filePath)  {
    return GestureDetector(
      onTap: () async {
        if (filePath != currentPlayingFile){
          await stopAudio();
          playAudio(filePath);
        }
        else {
          if (!isPlaying && isPaused){
            resumeAudio() ;
          }
          else if (isPlaying && isResumed ){
            pauseAudio() ;
          }
          else {
              playAudio(filePath) ;
            }
        }

      } ,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Icon(
                currentPlayingFile == filePath && isPlaying ? Icons.pause : Icons.play_arrow ,
                size: 36,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Audio ${recordedFiles.indexOf(filePath) + 1}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  // FutureBuilder<String>(
                  //   future: getDuaration(filePath).then(getFormattedDuration()),
                  //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       // While the future is loading, show a loading indicator or placeholder
                  //       return CircularProgressIndicator();
                  //     } else if (snapshot.hasError) {
                  //       // If there's an error, display an error message
                  //       print (snapshot.error) ;
                  //       print ('---------------here') ;
                  //       return Text('');
                  //     } else {
                  //       return Text(
                  //         snapshot.data?.toString() ?? '', // Use the duration value or an empty string
                  //         style: TextStyle(color: Colors.grey),
                  //       );
                  //     }
                  //   },
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recorder'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Recorded Files',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView.separated(
              itemCount: recordedFiles.length,
              separatorBuilder: (context, index) => Divider(height: 0.5),
              itemBuilder: (context, index) {
                final filePath = recordedFiles[index];
                return buildRecordItem(filePath);
              },
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: isRecording ? stopRecording : startRecording,
            child: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
          ),
        ],
      ),
    );
  }
}

