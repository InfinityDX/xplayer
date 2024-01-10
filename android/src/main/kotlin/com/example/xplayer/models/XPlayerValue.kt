package com.example.xplayer.models

import kotlinx.serialization.Serializable

@Serializable
data class XPlayerValue (
    val position: Long,
    val bufferedPosition: Long,
    val playbackSpeed: Float
)
