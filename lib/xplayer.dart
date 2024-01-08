
import 'xplayer_platform_interface.dart';

class Xplayer {
  Future<String?> getPlatformVersion() {
    return XplayerPlatform.instance.getPlatformVersion();
  }
}
