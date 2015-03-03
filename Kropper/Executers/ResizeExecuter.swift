//
//  ResizeExecuter.swift
//  Kropper
//
//  Created by zsaladin on 2015. 3. 4..
//  Copyright (c) 2015년 zsaladin. All rights reserved.
//

import Cocoa

class ResizeExecuter: SizeInputExecuter {
    override func execute() {
        Global.ViewControllerInstance.resize(Int(_size.width), height: Int(_size.height))
    }
}