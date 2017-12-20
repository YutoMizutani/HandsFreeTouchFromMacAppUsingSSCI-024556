//
//  ViewController.swift
//  Commands
//
//  Created by YutoMizutani on 20   17/12/16.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

/*
 References
 - https://www.mac-usb-serial.com/docs/tutorials/serial-port-programming-swift-mac-os-x.html
 - https://github.com/armadsen/ORSSerialPort
 */

/*
 Notes
 - 配布時
 - VC_V_LayoutLogTextView.swiftのFont指定を解除する。
 */


import Cocoa
import ORSSerial

class ViewController: NSViewController {
    //--BEGIN IBOutlet---------------------------------------------------------------------------------------//
    @IBOutlet var logTextView: NSTextView!
    //--END IBOutlet---------------------------------------------------------------------------------------//

    //--BEGIN Constants---------------------------------------------------------------------------------------//
    internal let settingsPath: String = "Settings.plist"
    //--END Constants---------------------------------------------------------------------------------------//

    //--BEGIN Variables---------------------------------------------------------------------------------------//
    internal var portName: String? = nil
    internal var sendingCommands: [String] = []
    internal var baudRate:NSNumber = 9600

    internal var sendingState: Int = 0
    internal var readString: String = ""

    var serialPort: ORSSerialPort? {
        didSet {
            oldValue?.close()
            oldValue?.delegate = nil
            serialPort?.delegate = self
        }
    }
    //--END Variables---------------------------------------------------------------------------------------//


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.layoutView()
        self.setup()
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        self.loop()
    }

    override func viewWillAppear() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(serialPortsWereConnected), name: NSNotification.Name.ORSSerialPortsWereConnected, object: nil)
        nc.addObserver(self, selector: #selector(serialPortsWereDisconnected), name: NSNotification.Name.ORSSerialPortsWereDisconnected, object: nil)

        NSUserNotificationCenter.default.delegate = self
    }
    override func viewWillDisappear() {
        if self.serialPort != nil {
            self.closeSerialPort(self.serialPort!)
        }
        NotificationCenter.default.removeObserver(self)
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
