package com.example.xplayer

import android.content.Context
import com.example.xplayer.views.XPlayerViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.systemchannels.KeyEventChannel.EventResponseHandler
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.platform.PlatformViewRegistry

/** XplayerPlugin */
class XplayerPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var platformRegistry: PlatformViewRegistry


  private val xplayer = XPlayer()



  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {

    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "xplayer")
    channel.setMethodCallHandler(this)
    platformRegistry = flutterPluginBinding.platformViewRegistry
    flutterPluginBinding.platformViewRegistry.registerViewFactory(
      "xplayer_viewer_default",
      XPlayerViewFactory(xplayer),
    )

  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "xplayer:removeView" -> xplayer.playerViewController.removeView(call) //d

      "xplayer:init" -> xplayer.init(context) //d
      "xplayer:claimExoPlayer" -> xplayer.claimExoPlayer(call) //d
      "xplayer:seekToNext" -> xplayer.seekToNext() //d
      "xplayer:seekTo" -> xplayer.seekTo(call)
      "xplayer:setPlayBackSpeed" -> xplayer.setPlayBackSpeed(call)
      "xplayer:seekToPreviousMediaItem" -> xplayer.seekToPreviousMediaItem() //d
      "xplayer:addMediaSource" -> xplayer.addMediaSource(call) //d
      "xplayer:addMediaSources" -> xplayer.addMediaSources(call, result) //d
      "xplayer:clearAllMediaSource" -> xplayer.clearAllMediaSource() //d
      "xplayer:play" -> xplayer.play() //d
      "xplayer:pause" -> xplayer.pause() //d
      "xplayer:dispose" -> xplayer.dispose() //d
      else -> result.success("Method Channel Not Available")
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    xplayer.dispose()
  }

  private fun registerViewer(result: Result){
    val id = "xplayer_view_" + java.util.UUID.randomUUID().toString()
     try {
      platformRegistry.registerViewFactory(
        id,
        XPlayerViewFactory(xplayer)
      )
      result.success(id.toString())
    }catch (e: Exception){
      result.success("null")
    }
  }



}
