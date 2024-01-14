//
//  XPlayerObserver.swift
//  xplayer
//
//  Created by Sovanreach on 14/1/24.
//

import Foundation
import AVFoundation
import Flutter

class XPlayerObserver: NSObject {
    var player: AVPlayer
    var flutterEventSink: FlutterEventSink
    
    init(player: AVPlayer, flutterEventSink: @escaping FlutterEventSink) {
        self.player = player
        self.flutterEventSink = flutterEventSink
    }
    
    func startObservation(){
        player.addPeriodicTimeObserver(forInterval: CMTime(value: 750, timescale: 1000), queue: DispatchQueue.main, using: { time in
            print("Time: \(self.player.currentTime().seconds)")
        }
        )
    }
    
}
