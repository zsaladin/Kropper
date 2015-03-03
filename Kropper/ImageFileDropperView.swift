//
//  ImageFileDropperView.swift
//  Kropper
//
//  Created by zsaladin on 2015. 3. 4..
//  Copyright (c) 2015년 zsaladin. All rights reserved.
//

import Cocoa

class ImageFileDropperView: NSView, NSDraggingDestination {
    
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        self.registerForDraggedTypes([NSFilenamesPboardType])
    }
    
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        var pasteBoard = sender.draggingPasteboard()
        var fileNames = pasteBoard.propertyListForType(NSFilenamesPboardType)! as NSArray
        var fileName = fileNames[0] as String
        Global.ViewControllerInstance.importImage(fileName)
        return true
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
        return NSDragOperation.Copy
    }
}
