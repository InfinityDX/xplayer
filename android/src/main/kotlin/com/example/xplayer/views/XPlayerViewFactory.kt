package com.example.xplayer.views

import android.content.Context
import com.example.xplayer.XPlayer
import com.example.xplayer.views.XPlayerView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class XPlayerViewFactory(private val xplayer: XPlayer) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        var creationParam: Map<String?, Any?>? = mapOf()
        try {
        creationParam = args as Map<String?, Any?>?
        }catch (_: Exception){/* */}
        return XPlayerView(xplayer,context, viewId, creationParam);
    }
}