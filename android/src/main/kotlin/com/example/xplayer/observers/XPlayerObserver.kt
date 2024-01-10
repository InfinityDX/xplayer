package com.example.xplayer.observers

import android.media.session.PlaybackState
import android.os.Handler
import android.os.Looper
import androidx.media3.common.Player
import com.example.xplayer.models.XPlayerValue
import io.flutter.plugin.common.EventChannel
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json


class XPlayerObserver(private val flutterEventSink: EventChannel.EventSink?) : Player.Listener {
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
                    flutterEventSink?.success(
                        Json.encodeToString(
                            XPlayerValue(
                                player!!.currentPosition,
                                player!!.bufferedPosition,
                                player!!.playbackParameters.speed
                            )
                        )
                    )
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

    
}