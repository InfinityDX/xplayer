import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:xplayer/models/media_item.dart';

import 'package:xplayer/views/xplayer_viewer.dart';
import 'package:xplayer/xplayer.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({super.key});

  @override
  State<ShortsPage> createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> {
  final xplayer = Xplayer.i;
  String url = '';

  int oldPage = 0;

  @override
  void initState() {
    xplayer.init();
    addSources();
    super.initState();
  }

  void addSources() async {
    await xplayer.addMediaSources([
      "https://wrs.youtubes.fan/temp/0be373aa-b4f2-40ea-9131-bb72bef5d752_11f1572f-dadd-4add-b204-b7a962031a52-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/fb116823-c82b-4faa-883e-10e30062ffbf_1fdb923c-3991-4dbb-ab20-b357531e8285-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/bd2376ce-a860-4a60-bdad-294ae3f4dfed_cfe77db9-fa48-4014-be34-760872bbd980-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/2555a9b8-4964-404e-b4a1-e5efd57f87f2_6be46a14-9abb-4403-8d70-9184dd9c8c41-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/e6bff528-b70b-4c2e-8bc7-9fd304b02cc5_5e76c009-a8f8-467c-bc42-6e832fbcffb3-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/b3c0bec3-4741-4757-8022-230f0a40a373_aa21f692-7cce-4b8c-8233-e34406c0e3da-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/9f71d63f-339d-4a91-8f13-22ad538e3679_7d2b051e-a88a-40c9-98a1-dc3f94d5e27e-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/26dba1e3-41b1-4833-ba26-56d944fcc9a8_1ec6921c-a25a-49de-a9ac-a3a5913f4a8c-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/34836643-5ce6-45be-a174-43e2c0a0cba5_695e62da-aae3-4704-bbe9-75832b1e4f82-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/e6dce46f-714f-4bf2-a672-5c89015b56e1_03e456fd-f219-4fa8-bc5f-de68c60a6c74-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/3b48e20a-e95b-466d-9b50-49cba6174f68_50af2f28-1728-4930-b7e0-2682644e60a5-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/0798b557-086c-4101-8b12-9601ce3779f5_1d617d6d-3c03-4d48-b3c7-6dc63a2f95f7-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/8fffa416-6f80-41a4-b609-41174e51bd98_48f93818-c86a-461d-9d34-c43b5121780e-playlist.m3u8",
      "https://wrs.youtubes.fan/temp/59852964-963b-4f8a-9fcd-3cd361ece5f5_c7722d32-3821-4a22-8ad0-2dbbb28bc09f-playlist.m3u8",
    ].map((e) => MediaItem(e)).toList());
    xplayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shorts'),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        onPageChanged: (value) {
          if (value > oldPage) {
            Xplayer.i.seekToNext();
          } else {
            Xplayer.i.seekToPreviousMediaItem();
          }
          oldPage = value;
          Xplayer.i.claimPlayer(Xplayer.i.viewIds[value]);
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                ),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 16 / 9,
                    child: const XPlayerViewer(),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '$index',
                  style: const TextStyle(fontSize: 28, color: Colors.red),
                ),
              )
            ],
          );

          // return Center(child: Text('$index'));
        },
      ),
    );
  }
}
