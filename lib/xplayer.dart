import 'package:xplayer/models/media_item.dart';

import 'xplayer_platform_interface.dart';

class Xplayer {
  Xplayer._();

  static Xplayer? _instance;

  /// Xplayer singleton instance
  static Xplayer get i => _instance ??= Xplayer._();

  static const defaultViewType = 'xplayer_viewer_default';

  List<String> viewIds = [];

  Future<String?> getPlatformVersion() {
    return XplayerPlatform.instance.getPlatformVersion();
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

  Future<void> clearMediaSource() async {
    return XplayerPlatform.instance.clearMediaSource();
  }

  Future<void> removeView(String viewId) async {
    viewIds.remove(viewId);
    return XplayerPlatform.instance.removeView(viewId);
  }

  Future<void> claimExoPlayer(String viewId) async {
    return XplayerPlatform.instance.claimExoPlayer(viewId);
  }
}
