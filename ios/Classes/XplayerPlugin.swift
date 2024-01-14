import Flutter
import UIKit

public class XplayerPlugin: NSObject, FlutterPlugin {
    let xplayer: XPlayer = XPlayer()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = XplayerPlugin()
        
        let channel = FlutterMethodChannel(name: "xplayer", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let eventChannel = FlutterEventChannel(name: "xplayer_events:state", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance.xplayer)
        
        
        let xplayerViewFactory = XPlayerViewFactory(xplayer: instance.xplayer, messenger: registrar.messenger())
        registrar.register(xplayerViewFactory, withId: "xplayer_viewer_default")
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("CallMethod" + call.method)
        switch call.method {
        case "getPlatformVersion":
            result("iOS fdfd" + UIDevice.current.systemVersion)
            
        case "xplayer:init":
            xplayer.initilize(result: result)
            
        case "xplayer:claimPlayer":
            xplayer.claimPlayer(call: call, result: result)
            
        case "xplayer:registerPlaylist":
            xplayer.registerPlaylist()
            result("registerPlaylist")
            
        case "xplayer:changePlaylist":
            xplayer.changePlaylist()
            result("changePlaylist")
            
        case "xplayer:seekToNext":
            xplayer.seekToNext()
            result("seekToNext")
            
        case "xplayer:seekTo":
            xplayer.seekTo()
            result("seekTo")
            
        case "xplayer:setPlayBackSpeed":
            xplayer.setPlayBackSpeed()
            result("setPlayBackSpeed")
            
        case "xplayer:seekToPreviousMediaItem":
            xplayer.seekToPreviousMediaItem()
            result("seekToPreviousMediaItem")
            
        case "xplayer:addMediaSource":
            xplayer.addMediaSource(call: call, result: result)
            result("addMediaSource")
            
        case "xplayer:addMediaSources":
            xplayer.addMediaSources()
            result("addMediaSources")
            
        case "xplayer:setMediaSource":
            xplayer.setMediaSource()
            result("setMediaSource")
            
        case "xplayer:setMediaSources":
            xplayer.setMediaSources()
            result("setMediaSources")
            
        case "xplayer:clearMediaSource":
            xplayer.clearMediaSource()
            result("clearMediaSource")
            
        case "xplayer:changeQuality":
            xplayer.changeQuality()
            result("changeQuality")
            
        case "xplayer:clearAllMediaSource":
            xplayer.clearAllMediaSource()
            result("clearAllMediaSource")
            
        case "xplayer:play":
            xplayer.play()
            result("play")
            
        case "xplayer:pause":
            xplayer.pause()
            result("pause")
            
        case "xplayer:dispose":
            xplayer.dispose()
            result("dispose")
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
}
