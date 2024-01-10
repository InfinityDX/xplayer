package com.example.xplayer.views

import android.content.Context
import android.graphics.Color
import android.view.View
import androidx.annotation.OptIn
import androidx.media3.common.util.UnstableApi
import androidx.media3.ui.PlayerView
import com.example.xplayer.XPlayer
import io.flutter.plugin.platform.PlatformView

@OptIn(UnstableApi::class)
class XPlayerView(
    private val xplayer: XPlayer,
    context: Context,
    id: Int,
    creationParams: Map<String?, Any?>?
) : PlatformView {
    //    private val textView: TextView
    private var playerView: PlayerView

    override fun getView(): View {
        return playerView
    }

    override fun dispose() {

    }

    init {
        playerView = PlayerView(context)
        playerView.useController = false
        playerView.setShutterBackgroundColor(Color.TRANSPARENT)
        val viewId = creationParams?.get("viewId") as String? ?: id.toString()
        xplayer.playerViewController.registerView(viewId, playerView)
    }
}