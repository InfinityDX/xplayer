// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json         = Json { allowStructuredMapKeys = true }
// val xPlayerValue = json.parse(XPlayerValue.serializer(), jsonString)

package com.example.xplayer.models

import androidx.annotation.Nullable
import kotlinx.serialization.Serializable

@Serializable
data class XPlayerValue (
     val position: Long = 0L,
     val bufferedPosition: Long = 0L,
     val playbackSpeed: Float = 0F,
     val qualities: List<Quality> = mutableListOf()
)

