import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:xplayer/xplayer.dart';

class XPlayerViewer extends StatelessWidget {
  const XPlayerViewer({super.key});

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:

        /// Virtual View
        return const AndroidView(
          viewType: Xplayer.viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: {},
          creationParamsCodec: StandardMessageCodec(),
        );

      /// Hybrid Compositon
      // return PlatformViewLink(
      //   viewType: viewType,
      //   surfaceFactory: (context, controller) {
      //     return AndroidViewSurface(
      //       controller: controller as AndroidViewController,
      //       hitTestBehavior: PlatformViewHitTestBehavior.opaque,
      //       gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
      //     );
      //   },
      //   onCreatePlatformView: (params) {
      //     return PlatformViewsService.initSurfaceAndroidView(
      //       id: params.id,
      //       viewType: viewType,
      //       layoutDirection: TextDirection.ltr,
      //       creationParams: {},
      //       creationParamsCodec: const StandardMessageCodec(),
      //       onFocus: () {
      //         params.onFocusChanged(true);
      //       },
      //     )
      //       ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
      //       ..create();
      //   },
      // );
      // case TargetPlatform.iOS:
      //   return UiKitView(
      //     viewType: viewType,
      //     layoutDirection: TextDirection.ltr,
      //     creationParams: const {},
      //     creationParamsCodec: const StandardMessageCodec(),
      //   );
      default:
        return const Center(
          child: Text(
            'Unsupported Platform for XPlayer',
            style: TextStyle(
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }
}
