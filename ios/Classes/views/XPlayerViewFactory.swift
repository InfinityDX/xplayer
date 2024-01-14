//
//  XPlayerViewFactory.swift
//  xplayer
//
//  Created by Sovanreach on 12/1/24.
//

import Flutter
import UIKit

class XPlayerViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    private var xplayer: XPlayer
    
    init(xplayer: XPlayer, messenger: FlutterBinaryMessenger) {
        self.xplayer = xplayer
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return XPlayerView(xplayer: xplayer, frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
    }
    
    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
}
