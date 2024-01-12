//
//  XPlayerView.swift
//  xplayer
//
//  Created by Sovanreach on 12/1/24.
//

import Flutter
import UIKit

class XPlayerView: NSObject, FlutterPlatformView {
    private var _view: UIView

        init(
            frame: CGRect,
            viewIdentifier viewId: Int64,
            arguments args: Any?,
            binaryMessenger messenger: FlutterBinaryMessenger?
        ) {
            _view = UIView()
            super.init()
            // iOS views can be created here
            createNativeView(view: _view)
        }

        func view() -> UIView {
            return _view
        }

        func createNativeView(view _view: UIView){
            _view.backgroundColor = UIColor.systemRed
            let nativeLabel = UILabel()
            nativeLabel.text = "Label"
            nativeLabel.textColor = UIColor.white
            nativeLabel.textAlignment = .center
            nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
            _view.addSubview(nativeLabel)
        }
}
