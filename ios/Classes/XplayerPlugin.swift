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
            xplayer.registerPlaylist(call: call, result: result)
            
        case "xplayer:changePlaylist":
            xplayer.changePlaylist(call: call, result: result)
            
        case "xplayer:seekToNext":
            xplayer.seekToNext(call: call, result: result)
            
        case "xplayer:seekTo":
            xplayer.seekTo()
            result("seekTo")
            
        case "xplayer:seekToPreviousMediaItem":
            xplayer.seekToPreviousMediaItem(call: call, result: result)
            
        case "xplayer:setPlayBackSpeed":
            xplayer.setPlayBackSpeed()
            result("setPlayBackSpeed")
            
        case "xplayer:addMediaSource":
            xplayer.addMediaSource(call: call, result: result)
            result("addMediaSource")
            
        case "xplayer:addMediaSources":
            xplayer.addMediaSources(call: call, result: result)
            result("addMediaSources")
            
        case "xplayer:setMediaSource":
            xplayer.setMediaSource(call: call, result: result)
            result("setMediaSource")
            
        case "xplayer:setMediaSources":
            xplayer.setMediaSources(call: call, result: result)
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
