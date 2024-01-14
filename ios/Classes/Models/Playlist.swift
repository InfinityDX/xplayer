//
//  Playlist.swift
//  integration_test
//
//  Created by Sovanreach on 14/1/24.
//

import Foundation
import AVFoundation

class Playlist: NSObject {
    var name: String = "default"
    var mediaSourceIndex: Int = 0
    var sources: Array<AVPlayerItem> = []
    
    override init() {}
    
     init(name: String) {
         self.name = name
    }
}
