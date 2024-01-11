package com.example.xplayer

import android.content.Context
import com.example.xplayer.views.XPlayerViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.platform.PlatformViewRegistry

/** XplayerPlugin */
class XplayerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private lateinit var context: Context
    private lateinit var platformRegistry: PlatformViewRegistry

    private val xplayer = XPlayer()

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "xplayer")
        channel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "xplayer_events:state")
        eventChannel.setStreamHandler(xplayer)

        platformRegistry = flutterPluginBinding.platformViewRegistry
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "xplayer_viewer_default",
            XPlayerViewFactory(xplayer),
        )

    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "xplayer:removeView" -> xplayer.playerViewController.removeView(call) //d

            "xplayer:init" -> xplayer.init(context, result) //d
            "xplayer:claimPlayer" -> xplayer.claimPlayer(call) //d
            "xplayer:registerPlaylist" -> xplayer.registerPlaylist(call, result)
            "xplayer:changePlaylist" -> xplayer.changePlaylist(call, result)
            "xplayer:seekToNext" -> xplayer.seekToNext() //d
            "xplayer:seekTo" -> xplayer.seekTo(call) //d
            "xplayer:setPlayBackSpeed" -> xplayer.setPlayBackSpeed(call) //d
            "xplayer:seekToPreviousMediaItem" -> xplayer.seekToPreviousMediaItem() //d
            "xplayer:addMediaSource" -> xplayer.addMediaSource(call) //d
            "xplayer:addMediaSources" -> xplayer.addMediaSources(call, result) //d
            "xplayer:setMediaSource" -> xplayer.setMediaSource(call) //d
            "xplayer:setMediaSources" -> xplayer.setMediaSources(call, result) //d
            "xplayer:changeQuality" -> xplayer.changeQuality(call) //d
            "xplayer:clearAllMediaSource" -> xplayer.clearAllMediaSource() //d
            "xplayer:play" -> xplayer.play() //d
            "xplayer:pause" -> xplayer.pause() //d
            "xplayer:dispose" -> xplayer.dispose(result) //d
            else -> result.success("Method Channel Not Available")
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        xplayer.dispose(null)
    }

}
