//
//  VC_VM_WriteLogTextView.swift
//  Commands
//
//  Created by YutoMizutani on 2017/12/16.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Cocoa

extension ViewController {
    internal func writeLogTextView(_ text: String) {
        print("log: \(text)")
        var str = text
        if !(str.contains("\r") || str.contains("\n")) {
            str += "\n"
        }
        self.logTextView.string += str
        self.logTextView.scroll(NSPoint.init(x: 0, y: -(self.logTextView.intrinsicContentSize.height - self.logTextView.bounds.height)))
    }
}
