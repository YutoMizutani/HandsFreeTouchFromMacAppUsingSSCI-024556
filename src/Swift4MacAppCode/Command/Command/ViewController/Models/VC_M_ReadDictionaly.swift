//
//  VC_M_ReadDictionaly.swift
//  Command
//
//  Created by YutoMizutani on 2017/12/20.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Cocoa

extension ViewController {
    internal func readDictionaly(_ path: String, key: String) -> Any? {
        if let path = Bundle.main.path(forResource: path, ofType: nil) {
            if let dictionaly = NSDictionary.init(contentsOfFile: path) {
                print(dictionaly)
                return dictionaly[key]
            }
        }
        return nil
    }
}
