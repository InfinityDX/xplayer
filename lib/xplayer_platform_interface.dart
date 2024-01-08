import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
