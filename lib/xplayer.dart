import 'package:xplayer/models/media_item.dart';

import 'xplayer_platform_interface.dart';

class Xplayer {
  static const viewType = 'xplayer_viewer';

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

  Future<void> clearMediaSource() async {
    return XplayerPlatform.instance.clearMediaSource();
  }
}
