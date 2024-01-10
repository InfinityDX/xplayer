import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:xplayer/models/media_item.dart';
import 'package:xplayer/models/xplayer_value.dart';

import 'xplayer_platform_interface.dart';

class Xplayer {
  static const defaultViewType = 'xplayer_viewer_default';

  final _eventChannel = const EventChannel('xplayer_events');

  static Xplayer? _instance;

  /// Xplayer singleton instance
  static Xplayer get i => _instance ??= Xplayer._();

  Xplayer._() {
    _eventChannel.receiveBroadcastStream().listen(onPlayerValueChanged);
  }

  final ValueNotifier<XPlayerValue> state = ValueNotifier(const XPlayerValue());

  List<String> viewIds = [];
  String currentViewId = '';

  void onPlayerValueChanged(dynamic event) {
    if (event is! String) {
      log('Event Data from native is not type String', name: "xplayer_events");
      return;
    }
    log(event, name: 'Xplayer');
    var xplayerValue = XPlayerValue.fromJson(event);
    state.value = xplayerValue;
  }

  Future<void> init() async {
    return XplayerPlatform.instance.init();
  }

  Future<void> seekToNext() {
    return XplayerPlatform.instance.seekToNext();
  }

  Future<void> seekToPreviousMediaItem() {
    return XplayerPlatform.instance.seekToPreviousMediaItem();
  }

  Future<void> play() {
    return XplayerPlatform.instance.play();
  }

  Future<void> pause() {
    return XplayerPlatform.instance.pause();
  }

  Future<void> addMediaSource(MediaItem item) async {
    return XplayerPlatform.instance.addMediaSource(item);
  }

  Future<void> addMediaSources(List<MediaItem> items) async {
    return XplayerPlatform.instance.addMediaSources(items);
  }

  Future<void> setMediaSource(MediaItem item) async {
    return XplayerPlatform.instance.setMediaSource(item);
  }

  Future<void> setMediaSources(List<MediaItem> items) async {
    return XplayerPlatform.instance.setMediaSources(items);
  }

  Future<void> clearMediaSource() async {
    return XplayerPlatform.instance.clearMediaSource();
  }

  Future<void> removeView(String viewId) async {
    viewIds.remove(viewId);
    return XplayerPlatform.instance.removeView(viewId);
  }

  Future<void> claimPlayer(String viewId) async {
    if (currentViewId == viewId) return;
    currentViewId = viewId;
    return XplayerPlatform.instance.claimPlayer(viewId);
  }

  Future<void> setPlayBackSpeed(double speed) async {
    return XplayerPlatform.instance.setPlayBackSpeed(speed);
  }

  Future<void> seekTo(Duration duration) {
    return XplayerPlatform.instance.seekTo(duration);
  }

  Future<void> changeQuality(Quality quality) {
    return XplayerPlatform.instance.changeQuality(quality);
  }

  Future<void> dispose() {
    return XplayerPlatform.instance.dispose();
  }
}
