//
//  XPlayerView.swift
//  xplayer
//
//  Created by Sovanreach on 12/1/24.
//

import Flutter
import UIKit
import AVKit
import AVFoundation

class XPlayerView: NSObject, FlutterPlatformView {
    private var playerView: PlayerView
    
    init(
        xplayer: XPlayer,
        frame: CGRect,
        viewIdentifier defaultViewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        var viewId = String(defaultViewId)
        if(args is Dictionary<String, String>) {
            viewId = (args as! Dictionary<String, String>)["viewId"] ?? viewId
        }
        
        let existingView = xplayer.playerViewController.getPlayerViewById(id: viewId)
        
        playerView = existingView ?? PlayerView()
        
        xplayer.playerViewController.registerView(id: viewId,view: playerView)
        
        super.init()
    }
    
    func view() -> UIView {
        return playerView
    }
}


class PlayerView : UIView{
    let playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        playerLayer.backgroundColor = UIColor.clear.cgColor
        self.backgroundColor = .clear
        self.layer.addSublayer(playerLayer)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        playerLayer.frame = self.frame
        super.layoutSubviews()
    }
    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
}
