//
//  ImageHelper.swift
//  Kropper
//
//  Created by zsaladin on 2015. 3. 4..
//  Copyright (c) 2015년 zsaladin. All rights reserved.
//

import Foundation
import Cocoa

class ImageHelper {
    
    class func imageScale(anImage:NSImage, newSize:NSSize) -> NSImage {
        var sourceImage = anImage
        var newImage = NSImage(size: newSize)
        newImage.lockFocus()
        sourceImage.size = newSize
        NSGraphicsContext.currentContext()?.imageInterpolation = NSImageInterpolation.High
        sourceImage.drawAtPoint(NSZeroPoint, fromRect: NSZeroRect, operation: NSCompositingOperation.CompositeCopy, fraction: CGFloat(1.0))
        newImage.unlockFocus()
        return newImage
    }
    
    class func imageCrop(imageView: NSImageView, cropBox: NSBox) -> NSImage {
        var sourceImage = imageView.image!
        var smallImage = NSImage(size: cropBox.borderRect.size)
        smallImage.lockFocus()
        
        var boxRect = cropBox.borderRect
        boxRect.origin.x = cropBox.frame.origin.x + (boxRect.width - cropBox.frame.width)
        boxRect.origin.y = cropBox.frame.origin.y + (boxRect.height - cropBox.frame.height)
        var newOrigin = NSPoint(x: -(boxRect.origin.x - imageView.frame.origin.x),
            y: -(boxRect.origin.y - imageView.frame.origin.y))
        
        NSGraphicsContext.currentContext()!.imageInterpolation = NSImageInterpolation.High
        sourceImage.drawAtPoint(newOrigin, fromRect: NSZeroRect, operation: NSCompositingOperation.CompositeCopy, fraction: 1.0)
        
        smallImage.unlockFocus()
        return smallImage
    }
    
    class func imageResize(anImage: NSImage, newSize: NSSize) -> NSImage {
        var sourceImage = anImage
        var extendImage = NSImage(size: newSize)
        
        extendImage.lockFocus()
        //        NSColor.redColor().set()
        getImageBackgroundColor(sourceImage)?.set()
        NSRectFill(NSMakeRect(0, 0, newSize.width, newSize.height))
        
        var beginPoint = NSMakePoint((newSize.width - sourceImage.size.width) * 0.5 , (newSize.height - sourceImage.size.height) * 0.5)
        NSGraphicsContext.currentContext()?.imageInterpolation = NSImageInterpolation.High
        sourceImage.drawAtPoint(beginPoint, fromRect: NSZeroRect, operation: NSCompositingOperation.CompositeCopy, fraction: CGFloat(1.0))
        extendImage.unlockFocus()
        
        
        return extendImage
    }
    
    class func getImageBackgroundColor(anImage: NSImage) -> NSColor? {
        var imageRep = NSBitmapImageRep(data: anImage.TIFFRepresentation!)!
        var imageSize = anImage.size
        var color = imageRep.colorAtX(1, y: 1)
        println(color!)
        return color
    }
}