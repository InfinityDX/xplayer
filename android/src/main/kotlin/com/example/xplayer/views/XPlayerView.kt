package com.example.xplayer.views

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import androidx.media3.ui.PlayerView
import com.example.xplayer.XPlayer
import io.flutter.plugin.platform.PlatformView

class XPlayerView(private val xplayer: XPlayer, context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
//    private val textView: TextView
//    private val playerView: PlayerView

    override fun getView(): View {
        return xplayer.getPlayerView()
//        return textView
    }

    override fun dispose() {}

//    init {
//        playerView = PlayerView(context)
//        textView = TextView(context)
//        textView.textSize = 24f
//        textView.setBackgroundColor(Color.rgb(255, 255, 255))
//        textView.text = "Rendered on a native Android view (id: $id)"
//    }
}