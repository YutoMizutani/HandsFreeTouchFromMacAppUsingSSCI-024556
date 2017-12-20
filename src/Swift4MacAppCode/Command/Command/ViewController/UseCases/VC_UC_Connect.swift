//
//  VC_UC_Connect.swift
//  Commands
//
//  Created by YutoMizutani on 2017/12/18.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Foundation

extension ViewController {
    internal func connect() {
        if self.portName == nil {
            self.writeLogTextView("Error! Enter port name!")
            self.writeLogTextView("Exit after \(10) seconds...")
            self.exit(delay: 10)
        }

        // すでに接続されていれば切断する。
        if self.serialPort != nil {
            self.writeLogTextView("Start disconnect...")
            self.closeSerialPort(self.serialPort!)
            self.writeLogTextView("Close to connect at \"\(self.portName!)\"")
            self.serialPort = nil
        }else{
            self.writeLogTextView("Start connect...")
            // 接続を試みる。
            if self.portName != nil {
                self.serialPort = self.connectSerialPort(self.portName!, baudRate: self.baudRate)
                if serialPort == nil {
                    self.writeLogTextView("Error! Failed to connect at \"\(self.portName!)\"")
                    self.writeLogTextView("Exit after \(10) seconds...")
                    self.exit(delay: 10)
                }else{
                    self.writeLogTextView("Success! connect at \"\(self.portName!)\"")
                }
            }
        }
    }
}
