//
//  VC_M_SerialPort.swift
//  Command
//
//  Created by YutoMizutani on 2017/12/16.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Cocoa
import ORSSerial

extension ViewController {
    internal func connectSerialPort(_ portName: String, baudRate: NSNumber=9600)->ORSSerialPort? {
        if let port: ORSSerialPort = ORSSerialPort(path: portName) {
            port.baudRate = baudRate
            port.open()
            print("Success! connect at \"\(portName)\"")
            return port
        }else{
            print("Error! Failed to create port at \"\(portName)\"")
            return nil
        }
    }
    internal func sendSerialPort(_ serialPort: ORSSerialPort, data: Data) {
        serialPort.send(data)
    }
    internal func closeSerialPort(_ serialPort: ORSSerialPort) {
        serialPort.close()
    }
}

