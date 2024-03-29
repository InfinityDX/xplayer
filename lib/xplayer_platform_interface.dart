import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:xplayer/models/media_item.dart';
import 'package:xplayer/models/xplayer_value.dart';

import 'xplayer_method_channel.dart';

abstract class XplayerPlatform extends PlatformInterface {
  /// Constructs a XplayerPlatform.
  XplayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static XplayerPlatform _instance = MethodChannelXplayer();

  /// The default instance of [XplayerPlatform] to use.
  ///
  /// Defaults to [MethodChannelXplayer].
  static XplayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [XplayerPlatform] when
  /// they register themselves.
  static set instance(XplayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> removeView(String viewId) {
    throw UnimplementedError('removeView() has not been implemented.');
  }

  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> registerPlaylist(String playListName) {
    throw UnimplementedError('registerPlaylist() has not been implemented.');
  }

  Future<void> changePlaylist(String playListName) {
    throw UnimplementedError('changePlaylist() has not been implemented.');
  }

  Future<void> seekToNext() {
    throw UnimplementedError('seekToNext() has not been implemented.');
  }

  Future<void> seekToPreviousMediaItem() {
    throw UnimplementedError(
      'seekToPreviousMediaItem() has not been implemented.',
    );
  }

  Future<void> play() {
    throw UnimplementedError('play() has not been implemented.');
  }

  Future<void> pause() {
    throw UnimplementedError('pause() has not been implemented.');
  }

  Future<void> addMediaSource(MediaItem item) {
    throw UnimplementedError('addMediaSource() has not been implemented.');
  }

  Future<void> addMediaSources(List<MediaItem> item) {
    throw UnimplementedError('addMediaSource() has not been implemented.');
  }

  Future<void> setMediaSource(MediaItem item) {
    throw UnimplementedError('setMediaSource() has not been implemented.');
  }

  Future<void> setMediaSources(List<MediaItem> item) {
    throw UnimplementedError('setMediaSource() has not been implemented.');
  }

  Future<void> clearAllMediaSource() {
    throw UnimplementedError('clearMediaSource() has not been implemented.');
  }

  Future<void> claimPlayer(String viewId) {
    throw UnimplementedError('claimExoPlayer() has not been implemented.');
  }

  Future<void> seekTo(Duration duration) {
    throw UnimplementedError('seekTo() has not been implemented.');
  }

  Future<void> setPlayBackSpeed(double speed) {
    throw UnimplementedError('setPlayBackSpeed() has not been implemented.');
  }

  Future<void> changeQuality(Quality? quality) {
    throw UnimplementedError('changeQuality() has not been implemented.');
  }

  Future<void> dispose() {
    throw UnimplementedError('dispose() has not been implemented.');
  }
}
