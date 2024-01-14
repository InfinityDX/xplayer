//
//  XPlayerValue.swift
//  xplayer
//
//  Created by Sovanreach on 14/1/24.
//

import Foundation

class XPlayerValue: NSObject, Codable {
    
    var playerState: Int = 1
    var position: Int = 0
    var bufferedPosition: Int=0
    var playbackSpeed: Float = 0.0
    var qualities: Array<Quality> = []
    
    override init() {
    }
    
    init(playerState: Int = 1, position: Int = 0, bufferedPosition: Int = 0 , playbackSpeed: Float = 0.0, qualities: Array<Quality> = []) {
        self.playerState = playerState
        self.position = position
        self.bufferedPosition = bufferedPosition
        self.playbackSpeed = playbackSpeed
        self.qualities = qualities
    }

}
