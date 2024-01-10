package com.example.xplayer.models

import kotlinx.serialization.Serializable

@Serializable
data class XPlayerValue (
    val position: Float,
    val bufferedPosition: Float,
    val playbackSpeed: Float
)
