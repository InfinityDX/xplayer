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

  String url = '';

  @override
  void initState() {
    xplayer.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              onChanged: (val) => url = val,
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
                  onPressed: () => xplayer.addMediaSource(MediaItem(url)),
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
