import Flutter
import UIKit

public class XplayerPlugin: NSObject, FlutterPlugin {
    let xplayer: XPlayer = XPlayer()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = XplayerPlugin()
        
        let eventChannel = FlutterEventChannel(name: "xplayer_events:state", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance.xplayer)
        
        
        let channel = FlutterMethodChannel(name: "xplayer", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let xplayerViewFactory = XPlayerViewFactory(messenger: registrar.messenger())
        registrar.register(xplayerViewFactory, withId: "xplayer_viewer_default")
    }
    
    public func handle(_ call: FlutterMethodCall,_ result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS fdfd" + UIDevice.current.systemVersion)
        case "xplayer:init":
            result("init")
            break
        case "xplayer:claimPlayer":
            result("claimPlayer")
            break
        case "xplayer:registerPlaylist":
            result("registerPlaylist")
            break
        case "xplayer:changePlaylist":
            result("changePlaylist")
            break
        case "xplayer:seekToNext":
            result("seekToNext")
            break
        case "xplayer:seekTo":
            result("seekTo")
            break
        case "xplayer:setPlayBackSpeed":
            result("setPlayBackSpeed")
            break
        case "xplayer:seekToPreviousMediaItem":
            result("seekToPreviousMediaItem")
            break
        case "xplayer:addMediaSource":
            result("addMediaSource")
            break
        case "xplayer:addMediaSources":
            result("addMediaSources")
            break
        case "xplayer:setMediaSource":
            result("setMediaSource")
            break
        case "xplayer:setMediaSources":
            result("setMediaSources")
            break
        case "xplayer:changeQuality":
            result("changeQuality")
            break
        case "xplayer:clearAllMediaSource":
            result("clearAllMediaSource")
            break
        case "xplayer:play":
            result("play")
            break
        case "xplayer:pause":
            result("pause")
            break
        case "xplayer:dispose":
            result("dispose")
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
}
