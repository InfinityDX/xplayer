package com.example.xplayer.observers

import android.media.session.PlaybackState
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.media3.common.Player
import com.example.xplayer.models.XPlayerValue
import io.flutter.plugin.common.EventChannel
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json


class XPlayerObserver(private val flutterEventSink: EventChannel.EventSink?) : Player.Listener {
    private val RUNNABLE_DELAY_MS = 100L

    private var handlerHasCallback = false

    private var handler: Handler = Handler(Looper.getMainLooper())
    private var runnable: Runnable? = null

    override fun onEvents(player: Player, events: Player.Events) {
        val playbackState = player.playbackState;
        Log.d("ExoPlayer", "$playbackState")

        if (playbackState == PlaybackState.STATE_PLAYING) {
            if (handlerHasCallback) return

            runnable = object : Runnable {
                override fun run() {
                    flutterEventSink?.success(
                        Json.encodeToString(
                            XPlayerValue(
                                player.currentPosition,
                                player.bufferedPosition,
                                player.playbackParameters.speed
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



        super.onEvents(player, events)
    }
}