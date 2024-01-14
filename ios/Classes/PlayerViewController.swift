//
//  PlayerViewController.swift
//  xplayer
//
//  Created by Sovanreach on 13/1/24.
//

import Flutter
import Foundation
import AVFoundation

class PlayerViewController: NSObject {
    private var playerViews: [String : PlayerView] = [:]
    private var currentPlayerViewId: String = ""
    
    func getCurrenView() -> UIView? {
        
        if(playerViews.isEmpty) { return nil }
        
        guard let playerView = playerViews[currentPlayerViewId] else{
            return nil
        }
        
        return playerView
    }
    
    func registerView(id: String, view: PlayerView){
        playerViews[id] = view
    }
    
    func remove(call: FlutterMethodCall, result: FlutterResult){
        guard let viewId = call.arguments as? String else{
            result("Arguments sent from Flutter is not String")
            return
        }
        playerViews.removeValue(forKey: viewId)
    }
    
    func getCurrentPlayerViewId() -> String {
        return currentPlayerViewId
    }
    
    func setCurrentPlayerViewId(id: String) {
        currentPlayerViewId = id
    }
    
    func getPlayerViewById(id: String) -> PlayerView? {
        return playerViews[id]
    }
    
    /// Special case for iOS,
    /// If you check Android implementation, you will see they have built-in switching player ```PlayerView.switchTargetView(player, oldPlayerView, newPlayerView)```
    /// This is manual switching player between oldPlayerView and newPlayerView
//    func switchTargetView(player: AVPlayer?, oldPlayerView: UIView?, newPlayerView: UIView?){
//        if(player == nil) {return}
//        
//
//        
//        if(newPlayerView != nil){
//            (oldPlayerView?.layer as! AVPlayerLayer).player = player
//        }
//        
//        if(oldPlayerView != nil) {
//            (oldPlayerView?.layer as! AVPlayerLayer).player = nil
//        }
//    }
}

