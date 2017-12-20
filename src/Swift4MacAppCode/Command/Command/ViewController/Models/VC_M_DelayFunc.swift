//
//  VC_M_DelayFunc.swift
//  Command
//
//  Created by YutoMizutani on 2017/12/18.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Foundation

extension ViewController {
    internal func delay(_ function: (), delay: Double) {
        DispatchQueue.global().asyncAfter(deadline: .now()+delay, execute: {
            DispatchQueue.main.async {
                function
            }
        })
    }
}
