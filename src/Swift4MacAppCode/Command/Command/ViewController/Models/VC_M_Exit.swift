//
//  VC_M_Exit.swift
//  Command
//
//  Created by YutoMizutani on 2017/12/18.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Cocoa

extension ViewController {
    internal func exit(delay: Int=0) {
        if delay == 0 {
            NSApplication.shared.terminate(self)
        }else{
            DispatchQueue.global().asyncAfter(deadline: .now()+Double(delay), execute: {
                DispatchQueue.main.async {
                    NSApplication.shared.terminate(self)
                }
            })
        }
    }
}
