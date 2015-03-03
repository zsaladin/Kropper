//
//  KropBox.swift
//  Kropper
//
//  Created by zsaladin on 2015. 3. 4..
//  Copyright (c) 2015년 zsaladin. All rights reserved.
//

import Cocoa

class KropBox: NSBox {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func popoverMenu() {
        var viewController = Global.ViewControllerInstance.storyboard!.instantiateControllerWithIdentifier("KropPopover")! as ViewController
        var popover = NSPopover()
        popover.contentSize = NSMakeSize(100, 100)
        popover.animates = true
        popover.contentViewController = viewController
        popover.showRelativeToRect(self.frame, ofView: self, preferredEdge: NSMaxXEdge)
    }
    
}
