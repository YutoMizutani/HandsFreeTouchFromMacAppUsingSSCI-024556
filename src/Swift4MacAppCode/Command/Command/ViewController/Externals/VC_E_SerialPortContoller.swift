//
//  VC_E_SerialPortContoller.swift
//  Commands
//
//  Created by YutoMizutani on 2017/12/16.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Cocoa
import ORSSerial

extension ViewController: ORSSerialPortDelegate, NSUserNotificationCenterDelegate {
    // 受信時
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        if let str = String(data: data, encoding: String.Encoding.utf8) {
            if str.contains("\r") || str.contains("\n") {
                let lineStr = str.contains("\r\n") ? "\r\n" : str.contains("\r") ? "\r" : "\n"
                let separatedStr = str.components(separatedBy: lineStr)
                self.readString += separatedStr[0].replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: "")

                if self.readString != "\r" && self.readString != "\n" && self.readString != "\r\n" && self.readString != " " && self.readString != "" {
                    self.writeLogTextView(">> \(self.readString)")
                }
                self.readString = separatedStr.count > 0 ? separatedStr[1] : ""
            }else{
                self.readString += str
            }
        }
        self.sendCommands()
    }

    func serialPortWasOpened(_ serialPort: ORSSerialPort) {
    }
    func serialPortWasClosed(_ serialPort: ORSSerialPort) {
    }
    func serialPortWasRemoved(fromSystem serialPort: ORSSerialPort) {
        print("serialPortWasRemoved")
        self.serialPort = nil
    }
    func serialPort(_ serialPort: ORSSerialPort, didEncounterError error: Error) {
        print("SerialPort \(serialPort) encountered an error: \(error)")
    }

    // MARK: - NSUserNotifcationCenterDelegate
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
        let popTime = DispatchTime.now() + Double(Int64(3.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) { () -> Void in
            center.removeDeliveredNotification(notification)
        }
    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }

    // MARK: - Notifications
    @objc func serialPortsWereConnected(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let connectedPorts = userInfo[ORSConnectedSerialPortsKey] as! [ORSSerialPort]
            print("Ports were connected: \(connectedPorts)")
            self.postUserNotificationForConnectedPorts(connectedPorts)
        }
    }
    @objc func serialPortsWereDisconnected(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let disconnectedPorts: [ORSSerialPort] = userInfo[ORSDisconnectedSerialPortsKey] as! [ORSSerialPort]
            print("Ports were disconnected: \(disconnectedPorts)")
            self.postUserNotificationForDisconnectedPorts(disconnectedPorts)
        }
    }
    func postUserNotificationForConnectedPorts(_ connectedPorts: [ORSSerialPort]) {
        let unc = NSUserNotificationCenter.default
        for port in connectedPorts {
            let userNote = NSUserNotification()
            userNote.title = NSLocalizedString("Serial Port Connected", comment: "Serial Port Connected")
            userNote.informativeText = "Serial Port \(port.name) was connected to your Mac."
            userNote.soundName = nil;
            unc.deliver(userNote)
        }
    }
    func postUserNotificationForDisconnectedPorts(_ disconnectedPorts: [ORSSerialPort]) {
        let unc = NSUserNotificationCenter.default
        for port in disconnectedPorts {
            let userNote = NSUserNotification()
            userNote.title = NSLocalizedString("Serial Port Disconnected", comment: "Serial Port Disconnected")
            userNote.informativeText = "Serial Port \(port.name) was disconnected from your Mac."
            userNote.soundName = nil;
            unc.deliver(userNote)
        }
    }
}
