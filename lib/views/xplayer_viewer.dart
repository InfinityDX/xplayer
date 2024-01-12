import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:xplayer/constants/player_state.dart';
import 'package:xplayer/xplayer.dart';

class XPlayerViewer extends StatefulWidget {
  final bool autoClaimPlayer;
  final String thumbnailUrl;
  const XPlayerViewer(
      {this.thumbnailUrl = '', this.autoClaimPlayer = false, super.key});

  @override
  State<XPlayerViewer> createState() => _XPlayerViewerState();
}

class _XPlayerViewerState extends State<XPlayerViewer>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  late String viewId;

  bool showPlaceHolder = false;

  Widget thumbnail = const Offstage();

  int playerState = PlayerState.IDLE;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    if (widget.thumbnailUrl.isNotEmpty) {
      thumbnail = Image.network(widget.thumbnailUrl);
    }

    viewId = UniqueKey().toString();
    Xplayer.i.viewIds.add(viewId);

    if (widget.autoClaimPlayer) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Xplayer.i.claimPlayer(viewId);
      });
    }
    Xplayer.i.state.addListener(playerStateListener);

    super.initState();
  }

  void playerStateListener() {
    if (playerState != Xplayer.i.state.value.playerState) {
      setState(() {
        playerState = Xplayer.i.state.value.playerState ?? PlayerState.IDLE;
      });
    }
  }

  @override
  void dispose() {
    log("Disposed");
    WidgetsBinding.instance.removeObserver(this);
    Xplayer.i.state.removeListener(playerStateListener);
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
        return Stack(
          children: [
            AndroidView(
              viewType: Xplayer.defaultViewType,
              layoutDirection: TextDirection.ltr,
              creationParams: {'viewId': viewId},
              creationParamsCodec: const StandardMessageCodec(),
            ),
            if (playerState == PlayerState.IDLE) Center(child: thumbnail),
            if (playerState == PlayerState.BUFFERING)
              Center(
                child: CircularProgressIndicator(
                  color: Colors.red[800]!,
                  strokeCap: StrokeCap.round,
                ),
              ),
          ],
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
