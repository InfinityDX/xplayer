// import 'package:flutter_test/flutter_test.dart';
// import 'package:xplayer/xplayer.dart';
// import 'package:xplayer/xplayer_platform_interface.dart';
// import 'package:xplayer/xplayer_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockXplayerPlatform
//     with MockPlatformInterfaceMixin
//     implements XplayerPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final XplayerPlatform initialPlatform = XplayerPlatform.instance;

//   test('$MethodChannelXplayer is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelXplayer>());
//   });

//   test('getPlatformVersion', () async {
//     Xplayer xplayerPlugin = Xplayer();
//     MockXplayerPlatform fakePlatform = MockXplayerPlatform();
//     XplayerPlatform.instance = fakePlatform;

//     expect(await xplayerPlugin.getPlatformVersion(), '42');
//   });
// }
