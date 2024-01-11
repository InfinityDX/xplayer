import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:xplayer/models/media_item.dart';
import 'package:xplayer/views/xplayer_viewer.dart';
import 'package:xplayer/xplayer.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  final xplayer = Xplayer.i;

  final url = TextEditingController();
  final playlist = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: url,
                    decoration: const InputDecoration(hintText: 'HLS Url'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 9 / 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                  child: const XPlayerViewer(autoClaimPlayer: true),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => xplayer.clearMediaSource(),
                        child: const Text('Clear Sources'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          xplayer.addMediaSource(
                            MediaItem(url.text),
                          );
                          url.text = '';
                        },
                        child: const Text('Add Source'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => xplayer.seekToPreviousMediaItem(),
                        child: const Text('Prevoius'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => xplayer.seekToNext(),
                        child: const Text('Next'),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: playlist,
                    decoration: const InputDecoration(
                      hintText: 'Playlist Name',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          xplayer.changePlaylist(playlist.text);
                          playlist.text = "";
                        },
                        child: const Text('Switch Playlist'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          xplayer.registerPlaylist(playlist.text);
                          playlist.text = "";
                        },
                        child: const Text('Add Playlist'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: Xplayer.i.state,
            builder: (context, playerState, _) {
              return SliverList.builder(
                itemCount: (playerState.qualities?.length ?? 0) + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Xplayer.i.changeQuality(null);
                        },
                        child: const Text('Auto'),
                      ),
                    );
                  }
                  var quality = playerState.qualities?[index - 1];

                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (quality == null) return;
                        Xplayer.i.changeQuality(quality);
                      },
                      child: Text(quality?.height.toString() ?? ''),
                    ),
                  );
                },
              );
              // return ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: playerState.qualities?.length ?? 0,
              //   itemBuilder: (context, index) {
              //     var quality = playerState.qualities?[index];
              //     return Center(
              //       child: ElevatedButton(
              //         onPressed: () {},
              //         child: Text(quality?.height.toString() ?? ''),
              //       ),
              //     );
              //   },
              // );
            },
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => xplayer.play(),
                child: const Text('Play'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => xplayer.pause(),
                child: const Text('Pause'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
