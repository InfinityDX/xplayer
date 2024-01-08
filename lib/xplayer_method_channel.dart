import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:xplayer/models/media_item.dart';

import 'xplayer_platform_interface.dart';

/// An implementation of [XplayerPlatform] that uses method channels.
class MethodChannelXplayer implements XplayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('xplayer');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> init() async {
    await methodChannel.invokeMethod('xplayer:init')
        // .timeout(
        //   const Duration(seconds: 10),
        //   onTimeout: () {
        //     log("XPlayer Initi timeout", name: 'XPlayer');
        //   },
        // )
        ;
  }

  @override
  Future<void> seekToNext() async {
    await methodChannel.invokeMethod('xplayer:seekToNext');
  }

  @override
  Future<void> seekToPreviousMediaItem() async {
    await methodChannel.invokeMethod('xplayer:seekToPreviousMediaItem');
  }

  @override
  Future<void> play() async {
    await methodChannel.invokeMethod('xplayer:play');
  }

  @override
  Future<void> pause() async {
    await methodChannel.invokeMethod('xplayer:pause');
  }

  @override
  Future<void> addMediaSource(MediaItem item) async {
    await methodChannel.invokeMethod('xplayer:addMediaSource', item.toMap());
  }

  @override
  Future<void> clearMediaSource() async {
    await methodChannel.invokeMethod('xplayer:clearMediaSource');
  }
}
