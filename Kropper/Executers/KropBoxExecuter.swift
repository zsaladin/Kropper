//
//  KropBoxExecuter.swift
//  Kropper
//
//  Created by zsaladin on 2015. 3. 4..
//  Copyright (c) 2015년 zsaladin. All rights reserved.
//

import Cocoa

class KropBoxExecuter: SizeInputExecuter {
    override func execute() {
        Global.ViewControllerInstance._cropBox.frame.size = _size
        Global.ViewControllerInstance._cropBox.frame.origin = NSZeroPoint
    }
}
