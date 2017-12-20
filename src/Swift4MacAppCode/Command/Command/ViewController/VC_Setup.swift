//
//  VC_Setup.swift
//  Commands
//
//  Created by YutoMizutani on 2017/12/16.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Cocoa

//---- set Actions ------------------------------------------------------------------------------------------------------------------------------
extension ViewController {
    internal func setup() {
        readPlist: do {
            self.portName = self.readDictionaly(self.settingsPath, key: "Port name") as? String
            self.sendingCommands = self.readDictionaly(self.settingsPath, key: "Command") as? [String] ?? []
            self.baudRate = NSNumber(value: Int(self.readDictionaly(self.settingsPath, key: "Baud rate") as? String ?? "9600") ?? 9600)
        }
    }
}
//-------------------------------------------------------------------------------------------------------------------------------------------------
