//
//  VC_V_LayoutLogTextView.swift
//  Commands
//
//  Created by YutoMizutani on 2017/12/16.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Cocoa

extension ViewController {
    internal func configureLayoutLogTextView(_ textView: NSTextView) {
        disableEditText: do{
            textView.isEditable = false
            textView.backgroundColor = NSColor.black
            textView.textColor = NSColor.white
//            textView.font = NSFont.init(name: "Ricty Discord", size: NSFont.systemFontSize)
        }
    }
}
