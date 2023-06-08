import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';


class AudioToBase64 {
  final recorder = FlutterSoundRecorder();

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
  }
  Future record() async {
    await recorder.startRecorder(toFile: 'audio');
  }
  Future<String?> stop() async {
    return await recorder.stopRecorder();
  }
  Future<String> encodeAudioToBase64(String audiPath) async {
    final audioFile = File(audiPath);
    final audioBytes = await audioFile.readAsBytes();
    final base64Audio = base64Encode(audioBytes);
    return base64Audio ;
  }

  Future<void> decodeBase64ToAudio(String base64String, String filePath) async {
    final bytes = base64Decode(base64String);
    File(filePath).writeAsBytesSync(bytes);

    final player = AudioPlayer();
    await player.play(DeviceFileSource(filePath));
  }
}