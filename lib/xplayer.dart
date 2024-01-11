import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:xplayer/models/media_item.dart';
import 'package:xplayer/models/xplayer_value.dart';

import 'xplayer_platform_interface.dart';

class Xplayer {
  static const defaultViewType = 'xplayer_viewer_default';

  static Xplayer? _instance;

  /// Xplayer singleton instance
  // @Deprecated(
  //     "Global Instance, Please Initialize your own instance using Xplayer()")
  static Xplayer get i => _instance ??= Xplayer._();

  Xplayer._() {
    _eventChannel.receiveBroadcastStream().listen(onPlayerValueChanged);
    init();
  }

  final _eventChannel = const EventChannel('xplayer_events');

  final ValueNotifier<bool> initialized = ValueNotifier(false);
  final ValueNotifier<XPlayerValue> state = ValueNotifier(const XPlayerValue());
  final List<String> playlistNames = [];
  final List<String> viewIds = [];
  String currentViewId = '';
  String currentPlaylist = 'default';

  void onPlayerValueChanged(dynamic event) {
    if (event is! String) {
      log('Event Data from native is not type String', name: "xplayer_events");
      return;
    }
    log(event, name: 'Xplayer');
    var xplayerValue = XPlayerValue.fromJson(event);
    state.value = xplayerValue;
  }

  /// Initialize player and its neccessary components in native.
  ///
  /// Usaully you don't need to call ```init()``` directly, getting ```Xplayer.i``` will initialize automatically
  ///
  /// You need to init again after calling ```dipose()```
  Future<void> init() async {
    await XplayerPlatform.instance.init();
    initialized.value = true;
  }

  Future<void> registerPlaylist(String playListName) async {
    if (playlistNames.contains(playListName)) return;
    playlistNames.add(playListName);
    await XplayerPlatform.instance.registerPlaylist(playListName);
  }

  Future<void> changePlaylist(String playListName) async {
    currentPlaylist = playListName;
    await XplayerPlatform.instance.changePlaylist(playListName);
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

  Future<void> changeQuality(Quality? quality) {
    return XplayerPlatform.instance.changeQuality(quality);
  }

  Future<void> dispose() async {
    initialized.value = false;
    XplayerPlatform.instance.dispose();
  }
}
