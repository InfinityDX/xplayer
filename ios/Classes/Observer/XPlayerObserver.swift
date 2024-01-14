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
    private var xplayer: XPlayer
    private var flutterEventSink: FlutterEventSink
    private var kvoObserver: NSKeyValueObservation?
    
    init(xplayer: XPlayer, flutterEventSink: @escaping FlutterEventSink) {
        self.xplayer = xplayer
        self.flutterEventSink = flutterEventSink
    }
    
    func startObservation(){
        xplayer.player.addPeriodicTimeObserver(forInterval: CMTime(value: 750, timescale: 1000), queue: DispatchQueue.main, using: { time in
            
            let state = self.xplayer.state
            state.position = Int(self.xplayer.player.currentTime().seconds * 1000)
            state.playbackSpeed = self.xplayer.player.rate

            self.emitState(state: state)
        }
        )
    }
    
    func dispose(){
        kvoObserver?.invalidate()
    }
    
    func emitState(state: XPlayerValue){
        do {
            let json = try JSONEncoder().encode(state)
            let jsonString = String(data: json, encoding: .utf8)
            self.flutterEventSink(jsonString)
        }catch{
            print("Could not encode XplayerValue to Json in Observer")
        }
    }
}
