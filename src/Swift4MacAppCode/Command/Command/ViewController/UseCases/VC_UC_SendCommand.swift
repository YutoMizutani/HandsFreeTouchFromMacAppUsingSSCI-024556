//
//  VC_UC_SendCommand.swift
//  Commands
//
//  Created by YutoMizutani on 2017/12/18.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Foundation

extension ViewController {
    internal func sendCommands() {
        // checkFGO(with: ">> touch("+self.sendFGOcommands[i-1]+", LOW")
        // Arduino側のログ出力に合わせ，最後のArduino出力に

        if self.serialPort == nil {
            self.writeLogTextView("Error! Could not enable connection!")
            self.writeLogTextView("Exit after \(10) seconds...")
            self.exit(delay: 10)
        }

        if self.sendingCommands.count == 0 {
            self.writeLogTextView("Error! Nothing send commands!")
            self.writeLogTextView("Exit after \(10) seconds...")
            self.exit(delay: 10)
        }

        if self.sendingState <= self.sendingCommands.count {
            let i = self.sendingState
            if i == 0 {
                if checkSending(with: ">> Start", without: ">> "+self.sendingCommands[i]) {
                    self.send(self.sendingCommands[0])
                    self.sendingState+=1
                }
            }else if i == self.sendingCommands.count {
                if checkSending(with: ">> touch("+self.sendingCommands[i-1]+", LOW") {
                    let delay: Int = 5
                    self.writeLogTextView("Exit after \(delay) seconds...")
                    self.exit(delay: delay)
                    self.sendingState+=1
                }
            }else if checkSending(with: ">> touch("+self.sendingCommands[i-1]+", LOW", without: ">> touch("+self.sendingCommands[i]+", LOW") {
                self.send(self.sendingCommands[i])
                self.sendingState+=1
            }
        }
    }

    internal func checkSending(with: String?=nil, without: String?=nil)->Bool {
        let log = self.logTextView.string
        return (with != nil ? log.contains(with!) : true) && (without != nil ? !(log.contains(without!)) : true)
    }
}

