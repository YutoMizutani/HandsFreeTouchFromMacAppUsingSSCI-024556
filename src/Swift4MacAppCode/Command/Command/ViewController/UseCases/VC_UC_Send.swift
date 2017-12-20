//
//  VC_UC_Send.swift
//  Commands
//
//  Created by YutoMizutani on 2017/12/18.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Foundation

extension ViewController {
    internal func send(_ string:String) {
        self.writeLogTextView("<< \(string)")
        if let data = string.data(using: String.Encoding.utf8) {
            self.serialPort?.send(data)
        }
    }
}
