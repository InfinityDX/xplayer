import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:xplayer/xplayer.dart';

class XPlayerViewer extends StatefulWidget {
  final bool autoClaimPlayer;
  const XPlayerViewer({this.autoClaimPlayer = false, super.key});

  @override
  State<XPlayerViewer> createState() => _XPlayerViewerState();
}

class _XPlayerViewerState extends State<XPlayerViewer>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  String viewType = Xplayer.defaultViewType;
  late String viewId;

  bool showPlaceHolder = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    viewId = UniqueKey().toString();
    Xplayer.i.viewIds.add(viewId);

    if (widget.autoClaimPlayer) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Xplayer.i.claimPlayer(viewId);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    log("Disposed");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // if (!isRegistered) {
        //   return const ColoredBox(color: Colors.black);
        // }

        /// Virtual View
        return AndroidView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: {'viewId': viewId},
          creationParamsCodec: const StandardMessageCodec(),
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
