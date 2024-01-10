package com.example.xplayer.observers

import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.media3.common.C
import androidx.media3.common.Player
import androidx.media3.common.Tracks
import com.example.xplayer.XPlayer
import com.example.xplayer.models.Quality
import io.flutter.plugin.common.EventChannel
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json


class XPlayerObserver(
    private val xplayer: XPlayer,
    private val flutterEventSink: EventChannel.EventSink?
) : Player.Listener {
    private val RUNNABLE_DELAY_MS = 250L

    private var player: Player? = null
    private var handlerHasCallback = false
    private var handler: Handler = Handler(Looper.getMainLooper())
    private var runnable: Runnable? = null

    override fun onEvents(player: Player, events: Player.Events) {
        if (this.player == null) this.player = player
        super.onEvents(player, events)
    }

    override fun onIsPlayingChanged(isPlaying: Boolean) {
        if (player == null) return

        if (isPlaying) {
            if (handlerHasCallback) return

            runnable = object : Runnable {
                override fun run() {
                    val newPlayerState = xplayer.state.copy(
                        position = player!!.currentPosition,
                        bufferedPosition = player!!.bufferedPosition,
                        playbackSpeed = player!!.playbackParameters.speed
                    )
                    xplayer.setPlayerState(newPlayerState)
                    flutterEventSink?.success(Json.encodeToString(newPlayerState))
                    handler.postDelayed(this, RUNNABLE_DELAY_MS)
                }
            }
            handler.postDelayed(runnable!!, RUNNABLE_DELAY_MS)
            handlerHasCallback = true
        } else {
            if (runnable != null) handler.removeCallbacks(runnable!!)
            handlerHasCallback = false
        }

        super.onIsPlayingChanged(isPlaying)
    }

    override fun onTracksChanged(tracks: Tracks) {
        val videoTrackGroup: Tracks.Group =
            tracks.groups.firstOrNull { it.type == C.TRACK_TYPE_VIDEO } ?: return

        val qualities = mutableListOf<Quality>()
        for (i in 0 until videoTrackGroup.length) {
            val trackSelected = videoTrackGroup.isTrackSelected(i)
            val trackSupported = videoTrackGroup.isTrackSupported(i)
            val trackFormat = videoTrackGroup.getTrackFormat(i)
            if (trackSupported) {
                Log.d("ExoPlayer", "Format: $trackFormat TrackSelected: $trackSelected")
            }
            val quality = Quality(trackFormat.width, trackFormat.height)
            qualities.add(quality)
        }
        val newPlayerState = xplayer.state.copy(qualities = qualities)
        xplayer.setPlayerState(newPlayerState)
        flutterEventSink?.success(Json.encodeToString(newPlayerState))

        super.onTracksChanged(tracks)
    }


}