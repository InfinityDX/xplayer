import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'xplayer_platform_interface.dart';

/// An implementation of [XplayerPlatform] that uses method channels.
class MethodChannelXplayer extends XplayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('xplayer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
