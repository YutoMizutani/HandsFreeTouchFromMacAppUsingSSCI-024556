//
//  VC_Layout.swift
//  Commands
//
//  Created by YutoMizutani on 2017/12/16.
//  Copyright © 2017 Yuto Mizutani. This software is released under the MIT License.
//

import Cocoa

//---- Set layout ------------------------------------------------------------------------------------------------------------------------
extension ViewController {
    internal func layoutView() {
        self.setLayout()
    }

    private func setLayout() {
        logTextView: do{
            self.configureLayoutLogTextView(logTextView)
        }
    }
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------

