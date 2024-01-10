package com.example.xplayer.models

import kotlinx.serialization.Serializable

@Serializable
data class Quality (
    val width: Int,
    val height: Int
)