//
//  XPlayer.swift
//  xplayer
//
//  Created by Sovanreach on 12/1/24.
//

import Flutter
import Foundation
import AVFoundation
import AVKit

class XPlayer:NSObject, FlutterStreamHandler{
    private let MAX_CAHCE_SIZE = 100 * 1024 * 1024 // in MB, in this case is 100MB
    private var playerObserver: XPlayerObserver?
    private var flutterEventSink: FlutterEventSink?
    private var isLooping = true
    
    var state = XPlayerValue()
    
    
    var player: AVPlayer = AVPlayer()
    var playerViewController: PlayerViewController = PlayerViewController()
    var playLists: Dictionary<String, Playlist> = ["default" : Playlist()]
    var currentPlaylist: String = "default"
    
    
    func setPlayerState(newValue: XPlayerValue) {
        state = newValue
    }
    
    func initilize(result: FlutterResult){
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        //        playerObserver?.startObservation()
        let observer = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: .main) { [weak self] _ in
            if(self?.isLooping ?? false){
                self?.player.seek(to: CMTime.zero)
                self?.player.play()
            }
        }
        result("XPlayer Initialized")
    }
    
    func claimPlayer(call: FlutterMethodCall, result: FlutterResult){
        guard let viewId = call.arguments as? String else {
            result("viewId is not String | Parsed Value: \(String(describing: call.arguments))")
            return
        }
        
        let oldPlayerView = playerViewController.getCurrenView()
        let newPlayerView = playerViewController.getPlayerViewById(id: viewId)
        
        
        
        if(oldPlayerView != nil){
            (oldPlayerView?.layer as? AVPlayerLayer)?.player = nil
            // Create a UIImage from the CGImage
            
        }
        
        if(newPlayerView != nil){
            (newPlayerView?.layer as? AVPlayerLayer)?.player = player
        }
        
        playerViewController.setCurrentPlayerViewId(id: viewId)
    }
    
    func registerPlaylist(call: FlutterMethodCall, result: FlutterResult){
        guard let playlistName = call.arguments as? String else{
            result("Playlist Name is not String")
            return
        }
        
        if(playlistName.isEmpty){
            result("Playlist Name cannot be empty")
            return
        }
        
        if(playLists[playlistName] == nil){
            playLists[playlistName] = Playlist(name: playlistName)
            result("Playlist \(playlistName) Added")
        }
    }
    
    func changePlaylist(call: FlutterMethodCall, result: FlutterResult){
        guard let playlistName = call.arguments as? String else{
            result("playlistName is not String")
            return
        }
        
        if(playLists[playlistName] == nil) {
            result("Playlist not exist")
            return
        }
        
        guard let sources = playLists[playlistName]?.sources else{
            result("Sources not exist")
            return
        }
        let playIndex = playLists[playlistName]?.mediaSourceIndex ?? 0
        
        player.replaceCurrentItem(with: sources[playIndex])
        currentPlaylist = playlistName
        
    }
    
    func seekToNext(call: FlutterMethodCall, result: FlutterResult){
        guard let playList = playLists[currentPlaylist] else{
            result("Playlist not found")
            return
        }
        
        
        let playIndex = playList.mediaSourceIndex + 1
        playList.sources[playIndex].seek(to: CMTime.zero, completionHandler: nil)
        player.replaceCurrentItem(with: playList.sources[playIndex])
        playList.mediaSourceIndex = playIndex
        player.play()
    }
    
    func seekTo(){
        
    }
    
    func seekToPreviousMediaItem(call: FlutterMethodCall, result: FlutterResult){
        guard let playList = playLists[currentPlaylist] else{
            result("Playlist not found")
            return
        }
        
        
        var playIndex = playList.mediaSourceIndex - 1
        if(playIndex < 0){ playIndex = 0}
        
        playList.sources[playIndex].seek(to: CMTime.zero, completionHandler: nil)
        player.replaceCurrentItem(with: playList.sources[playIndex])
        playList.mediaSourceIndex = playIndex
        player.play()
    }
    
    func setPlayBackSpeed(call: FlutterMethodCall, result: FlutterResult){
        guard let playbackSpeed = call.arguments as? Double  else{
            result("Playback Speed is not Double")
            return
        }
        player.rate = Float(playbackSpeed);
    }
    
    func addMediaSource(call: FlutterMethodCall, result: FlutterResult){
        guard let arg = call.arguments as? Dictionary<String, String>? else{
            result("MediaSource data is not a Map/Dictionary")
            return
        }
        
        guard let url = arg?["url"] else{
            result("url is not String")
            return
        }
        
        guard let urlInstance = URL(string: url) else{
            result("Failed to Parse URL")
            return
        }
        let mediaAsset = AVAsset(url: urlInstance)
        let mediaItem = AVPlayerItem(asset: mediaAsset)
        playLists[currentPlaylist]?.sources.append(mediaItem)
        
        result("Add Media Source Success")
    }
    
    func addMediaSources(call: FlutterMethodCall, result: FlutterResult){
        guard let arg = call.arguments as? Array<Any> else{
            result("MediaSources data is not Array")
            return
        }
        
        for it in arg {
            guard let source = it as? Dictionary<String, String> else{
                continue
            }
            
            guard let url = URL(string: source["url"] ?? "") else{
                continue
            }
            
            let mediaAsset = AVAsset(url: url)
            let mediaItem = AVPlayerItem(asset: mediaAsset)
            playLists[currentPlaylist]?.sources.append(mediaItem)
        }
        result("Add Media Sources Success")
    }
    
    func setMediaSource(call: FlutterMethodCall, result: FlutterResult){
        guard let arg = call.arguments as? Dictionary<String, String>? else{
            result("MediaSource data is not a Map/Dictionary")
            return
        }
        
        guard let url = arg?["url"] else{
            result("url is not String")
            return
        }
        
        guard let urlInstance = URL(string: url) else{
            result("Failed to Parse URL")
            return
        }
        
        let mediaAsset = AVAsset(url: urlInstance)
        let mediaItem = AVPlayerItem(asset: mediaAsset)
        playLists[currentPlaylist]?.sources.removeAll()
        playLists[currentPlaylist]?.sources.append(mediaItem)
        result("Set Media Source Success")
    }
    
    func setMediaSources(call: FlutterMethodCall, result: FlutterResult){
        guard let arg = call.arguments as? Array<Any> else{
            result("MediaSources data is not Array")
            return
        }
        
        playLists[currentPlaylist]?.sources.removeAll()
        for it in arg {
            guard let source = it as? Dictionary<String, String> else{
                continue
            }
            
            guard let url = URL(string: source["url"] ?? "") else{
                continue
            }
            
            let mediaAsset = AVAsset(url: url)
            let mediaItem = AVPlayerItem(asset: mediaAsset)
            playLists[currentPlaylist]?.sources.append(mediaItem)
        }
        result("Add Media Sources Success")
    }
    
    func clearMediaSource(){
        playLists[currentPlaylist]?.sources.removeAll()    }
    
    func changeQuality(){
        
    }
    
    func clearAllMediaSource(){
        
    }
    
    func play(){
        guard let currentPlayIndex = playLists[currentPlaylist]?.mediaSourceIndex else{
            return
        }
        guard let sources = playLists[currentPlaylist]?.sources else{
            return
        }
        
        player.replaceCurrentItem(with: sources[currentPlayIndex])
        player.play()
    }
    func pause(){
        player.pause()
    }
    func dispose(){
        
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        flutterEventSink = events
        
        playerObserver = XPlayerObserver(xplayer: self, flutterEventSink: events)
        playerObserver?.startObservation()
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        playerObserver?.dispose()
        flutterEventSink = nil
        
        return nil
    }
    
    
    let fakeData = [
        "https://wrs.youtubes.fan/temp/0be373aa-b4f2-40ea-9131-bb72bef5d752_11f1572f-dadd-4add-b204-b7a962031a52-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/fb116823-c82b-4faa-883e-10e30062ffbf_1fdb923c-3991-4dbb-ab20-b357531e8285-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/bd2376ce-a860-4a60-bdad-294ae3f4dfed_cfe77db9-fa48-4014-be34-760872bbd980-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/2555a9b8-4964-404e-b4a1-e5efd57f87f2_6be46a14-9abb-4403-8d70-9184dd9c8c41-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/e6bff528-b70b-4c2e-8bc7-9fd304b02cc5_5e76c009-a8f8-467c-bc42-6e832fbcffb3-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/b3c0bec3-4741-4757-8022-230f0a40a373_aa21f692-7cce-4b8c-8233-e34406c0e3da-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/9f71d63f-339d-4a91-8f13-22ad538e3679_7d2b051e-a88a-40c9-98a1-dc3f94d5e27e-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/26dba1e3-41b1-4833-ba26-56d944fcc9a8_1ec6921c-a25a-49de-a9ac-a3a5913f4a8c-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/34836643-5ce6-45be-a174-43e2c0a0cba5_695e62da-aae3-4704-bbe9-75832b1e4f82-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/e6dce46f-714f-4bf2-a672-5c89015b56e1_03e456fd-f219-4fa8-bc5f-de68c60a6c74-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/3b48e20a-e95b-466d-9b50-49cba6174f68_50af2f28-1728-4930-b7e0-2682644e60a5-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/0798b557-086c-4101-8b12-9601ce3779f5_1d617d6d-3c03-4d48-b3c7-6dc63a2f95f7-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/8fffa416-6f80-41a4-b609-41174e51bd98_48f93818-c86a-461d-9d34-c43b5121780e-playlist.m3u8",
        "https://wrs.youtubes.fan/temp/59852964-963b-4f8a-9fcd-3cd361ece5f5_c7722d32-3821-4a22-8ad0-2dbbb28bc09f-playlist.m3u8",
    ]
}
