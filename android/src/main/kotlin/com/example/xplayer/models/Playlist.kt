package com.example.xplayer.models

import androidx.media3.exoplayer.hls.HlsMediaSource

class Playlist(
    var name: String = "",
    var mediaSourceIndex: Int = 0,
    var sources: MutableList<HlsMediaSource> = mutableListOf<HlsMediaSource>()
)