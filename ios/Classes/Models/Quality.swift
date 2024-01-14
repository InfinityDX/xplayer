//
//  Quality.swift
//  xplayer
//
//  Created by Sovanreach on 14/1/24.
//

import Foundation

class Quality: Codable {
    var width: Int
    var height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}
