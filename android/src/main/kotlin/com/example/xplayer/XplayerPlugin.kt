package com.example.xplayer

import android.content.Context
import com.example.xplayer.views.XPlayerViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** XplayerPlugin */
class XplayerPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context


  private val xplayer = XPlayer()



  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "xplayer")
    channel.setMethodCallHandler(this)
    flutterPluginBinding.platformViewRegistry.registerViewFactory(
      "xplayer_viewer",
      XPlayerViewFactory(xplayer),
    )

  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "xplayer:init" -> xplayer.init(context)
      "xplayer:seekToNext" -> xplayer.seekToNext()
      "xplayer:seekToPreviousMediaItem" -> xplayer.seekToPreviousMediaItem()
      "xplayer:addMediaSource" -> xplayer.addMediaSource(call)
      "xplayer:clearAllMediaSource" -> xplayer.clearAllMediaSource()
      "xplayer:play" -> xplayer.play()
      "xplayer:pause" -> xplayer.pause()
      else -> result.success("Method Channel Not Available")
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

}
