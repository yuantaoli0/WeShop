import 'dart:async';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class RingTone {
  static AudioPlayer? audioPlayer;
  static Source? _source;

  static playAlarm() async {
    if (_source == null) {
      try {
        _source = AssetSource('assets/ao.mp3');
      } catch (ex) {
        log(ex.toString());
        return;
      }
    }
    if (audioPlayer == null) {
      audioPlayer = AudioPlayer();
      await audioPlayer?.setReleaseMode(ReleaseMode.stop);
    }
    //FlutterRingtonePlayer.playAlarm(volume: 1, looping: false);
    Timer(Duration(seconds: 1), () {
      audioPlayer?.stop();
      //FlutterRingtonePlayer.stop();
    });
    //var wav = File('assets/ao.wav').readAsBytesSync();
    await audioPlayer?.play(_source!);
    /*FlutterRingtonePlayer.play(
      android: AndroidSounds.alarm,
      ios: IosSounds.glass,
      looping: false, // Android only - API >= 28
      volume: 1, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );*/
  }
}
