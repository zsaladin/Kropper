//
//  ScaleExecuter.swift
//  Kropper
//
//  Created by zsaladin on 2015. 3. 4..
//  Copyright (c) 2015년 zsaladin. All rights reserved.
//

import Cocoa

class ScaleExecutor: SizeInputExecuter {
    override func execute() {
        Global.ViewControllerInstance.scale(Int(_size.width), height: Int(_size.height))
    }
}