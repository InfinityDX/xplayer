import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:xplayer/models/media_item.dart';
import 'package:xplayer/models/xplayer_value.dart';

import 'xplayer_platform_interface.dart';

/// An implementation of [XplayerPlatform] that uses method channels.
class MethodChannelXplayer implements XplayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('xplayer');

  @override
  Future<void> init() async {
    await methodChannel.invokeMethod('xplayer:init');
  }

  @override
  Future<void> registerPlaylist(String playListName) async {
    await methodChannel.invokeMethod('xplayer:registerPlaylist', playListName);
  }

  @override
  Future<void> changePlaylist(String playListName) async {
    await methodChannel.invokeMethod('xplayer:changePlaylist', playListName);
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
  Future<void> addMediaSources(List<MediaItem> items) async {
    log(items.map((e) => e.toMap()).toList().toString(), name: 'Xplayer');
    var result = await methodChannel.invokeMethod(
      'xplayer:addMediaSources',
      items.map((e) => e.toMap()).toList(),
    );

    log(result, name: 'xplayer:addMediaSources');
  }

  @override
  Future<void> setMediaSource(MediaItem item) async {
    await methodChannel.invokeMethod('xplayer:setMediaSource', item.toMap());
  }

  @override
  Future<void> setMediaSources(List<MediaItem> items) async {
    log(items.map((e) => e.toMap()).toList().toString(), name: 'Xplayer');
    var result = await methodChannel.invokeMethod(
      'xplayer:setMediaSources',
      items.map((e) => e.toMap()).toList(),
    );

    log(result, name: 'xplayer:addMediaSources');
  }

  @override
  Future<void> clearMediaSource() async {
    await methodChannel.invokeMethod('xplayer:clearMediaSource');
  }

  @override
  Future<void> removeView(String viewId) async {
    await methodChannel.invokeMethod('xplayer:removeView', viewId);
  }

  @override
  Future<void> claimPlayer(String viewId) async {
    await methodChannel.invokeMethod('xplayer:claimPlayer', viewId);
  }

  @override
  Future<void> seekTo(Duration duration) async {
    await methodChannel.invokeMethod('xplayer:seekTo', duration.inMilliseconds);
  }

  @override
  Future<void> setPlayBackSpeed(double speed) async {
    await methodChannel.invokeMethod('xplayer:setPlayBackSpeed', speed);
  }

  @override
  Future<void> dispose() async {
    await methodChannel.invokeMethod('xplayer:dispose');
  }

  @override
  Future<void> changeQuality(Quality? quality) async {
    await methodChannel.invokeMethod('xplayer:changeQuality', quality?.toMap());
  }
}
