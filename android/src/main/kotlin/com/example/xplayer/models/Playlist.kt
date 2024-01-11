package com.example.xplayer.models

import androidx.media3.exoplayer.hls.HlsMediaSource

class Playlist(
    var name: String = "",
    var currentMediaSourceIndex: Int = 0,
    var sources: List<HlsMediaSource> = mutableListOf<HlsMediaSource>()
)