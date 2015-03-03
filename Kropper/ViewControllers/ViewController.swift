//
//  ViewController.swift
//  Kropper
//
//  Created by zsaladin on 2015. 3. 4..
//  Copyright (c) 2015년 zsaladin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var _imageView: NSImageView!
    @IBOutlet weak var _cropBox: KropBox!
    
    var _isCropBoxMovingSelected: Bool = false
    var _isCropBoxCreateSelected: Bool = false
    var _isCropBoxResizingSelected: [Bool] = [false, false, false, false]
    var _isCropBoxResizingOver: [Bool] = [false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Global.ViewControllerInstance = self
        
        var options = (NSTrackingAreaOptions.ActiveAlways | NSTrackingAreaOptions.InVisibleRect |
            NSTrackingAreaOptions.MouseEnteredAndExited | NSTrackingAreaOptions.MouseMoved);
        
        var trackingArea = NSTrackingArea(rect: self.view.bounds, options: options, owner: self.view, userInfo: nil)
        self.view.addTrackingArea(trackingArea)
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
            
        }
    }
    
    func isThis(point:NSPoint, At side:Direction ) -> Bool{
        var cropBoxXMin = _cropBox.frame.origin.x
        var cropBoxXMax = _cropBox.frame.origin.x + _cropBox.frame.size.width
        var cropBoxYMin = _cropBox.frame.origin.y
        var cropBoxYMax = _cropBox.frame.origin.y + _cropBox.frame.size.height
        
        if side == Direction.Left {
            return (cropBoxXMin - sensetive < point.x && point.x < cropBoxXMin + sensetive)
        }
        
        if side == Direction.Right {
            return (cropBoxXMax - sensetive < point.x && point.x < cropBoxXMax + sensetive)
        }
        
        if side == Direction.Down {
            return (cropBoxYMin - sensetive < point.y && point.y < cropBoxYMin + sensetive)
        }
        
        if side == Direction.Up {
            return (cropBoxYMax - sensetive < point.y && point.y < cropBoxYMax + sensetive)
        }
        
        return false
    }
    
    func isThis(point:NSPoint, InCropBox cropBox:NSBox) -> Bool {
        var cropBoxXMin = cropBox.frame.origin.x
        var cropBoxXMax = cropBox.frame.origin.x + cropBox.frame.size.width
        var cropBoxYMin = cropBox.frame.origin.y
        var cropBoxYMax = cropBox.frame.origin.y + cropBox.frame.size.height
        
        return (cropBoxXMin < point.x && point.x < cropBoxXMax &&
            cropBoxYMin < point.y && point.y < cropBoxYMax);
    }
    
    func resetWindow(newImage: NSImage) {
        resetWindow(newImage.size)
        _imageView.image = newImage
    }
    
    func resetWindow(newSize: NSSize) {
        self.view.window!.setContentSize(newSize)
        _imageView.frame.size = newSize
        _imageView.frame.origin = NSZeroPoint
    }
    
    func importImage(imagePath: String) {
        Global.Instance.imagePath = imagePath
        
        var image = NSImage(contentsOfFile: imagePath)
        var imageRep = image?.representations[0] as NSImageRep
        resetWindow(image!)
    }
    
    func exportImage(imagePath: String) {
        Global.Instance.imagePath = imagePath
        
        if _imageView.image == nil {
            return
        }
        
        var image = _imageView.image!
        var imageData = image.TIFFRepresentation!
        var imageRep = NSBitmapImageRep(data: imageData)
        var imageProsp = NSDictionary(object: NSNumber(float: 1.0), forKey: NSImageCompressionFactor)
        imageData = imageRep!.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: imageProsp)!
        imageData.writeToFile(imagePath + ".png", atomically: false)
        println(imagePath)
    }
    
    func scale(width:Int, height:Int) {
        var sourceImage = _imageView.image
        var resizedImage = ImageHelper.imageScale(sourceImage!, newSize: NSSize(width: width, height: height))
        resetWindow(resizedImage)
    }
    
    func crop() {
        println("imageView \(_imageView.frame), crop \(_cropBox.borderRect)")
        var origin = _imageView.frame.origin
        _imageView.image = ImageHelper.imageCrop(_imageView, cropBox: _cropBox)
        
        var newFrame = _cropBox.frame
        newFrame.size = _cropBox.frame.size
        newFrame.origin.x = _cropBox.frame.origin.x + (_cropBox.borderRect.width - _cropBox.frame.width)
        newFrame.origin.y = _cropBox.frame.origin.y + (_cropBox.borderRect.height - _cropBox.frame.height)
        
        _imageView.frame = newFrame
    }
    
    func resize(width: Int, height: Int) {
        //        var newSize = NSSize(width: width, height: height)
        //        var newImage = ImageHelper.imageResize(_imageView.image!, newSize: newSize)
        //        resetWindow(newImage)
        _cropBox.popoverMenu()
    }
    
    override func mouseDown(theEvent: NSEvent) {
        var mousePoint = theEvent.locationInWindow
        
        var isResized = false
        
        if isThis(mousePoint, At: Direction.Left) {
            _isCropBoxResizingSelected[Direction.Left.rawValue] = true
            isResized = true
        }
        
        if isThis(mousePoint, At: Direction.Right) {
            _isCropBoxResizingSelected[Direction.Right.rawValue] = true
            isResized = true
        }
        
        if isThis(mousePoint, At: Direction.Down) {
            _isCropBoxResizingSelected[Direction.Down.rawValue] = true
            isResized = true
        }
        
        if isThis(mousePoint, At: Direction.Up) {
            _isCropBoxResizingSelected[Direction.Up.rawValue] = true
            isResized = true
        }
        
        if isResized {
            return
        }
        
        if isThis(mousePoint, InCropBox: _cropBox) {
            _isCropBoxMovingSelected = true
        }
        else {
            _cropBox.frame.origin = mousePoint
            _cropBox.frame.size = NSZeroSize
            _isCropBoxResizingSelected[Direction.Down.rawValue] = true
            _isCropBoxResizingSelected[Direction.Right.rawValue] = true
        }
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        if _isCropBoxResizingSelected[Direction.Right.rawValue] {
            _cropBox.frame.size.width += theEvent.deltaX
        }
        else if _isCropBoxResizingSelected[Direction.Left.rawValue] {
            _cropBox.frame.size.width -= theEvent.deltaX
            _cropBox.frame.origin.x += theEvent.deltaX
        }
        
        if _isCropBoxResizingSelected[Direction.Up.rawValue] {
            _cropBox.frame.size.height -= theEvent.deltaY
        }
        else if _isCropBoxResizingSelected[Direction.Down.rawValue] {
            _cropBox.frame.size.height += theEvent.deltaY
            _cropBox.frame.origin.y -= theEvent.deltaY
        }
        
        if _isCropBoxMovingSelected {
            _cropBox.frame.origin.x += theEvent.deltaX
            _cropBox.frame.origin.y -= theEvent.deltaY
        }
        
    }
    
    override func mouseUp(theEvent: NSEvent) {
        _isCropBoxMovingSelected = false
        for var i = 0; i < _isCropBoxResizingSelected.count; ++i {
            _isCropBoxResizingSelected[i] = false
        }
        
        if _cropBox.frame.size.width == 0 || _cropBox.frame.size.height == 0 {
            _cropBox.frame.origin = NSMakePoint(-10, -10)
            _cropBox.frame.size = NSZeroSize
        }
    }
    
    override func mouseMoved(theEvent: NSEvent) {
        for var i = 0; i < _isCropBoxResizingOver.count; ++i {
            _isCropBoxResizingOver[i] = false
        }
        var mousePoint = theEvent.locationInWindow
        
        if isThis(mousePoint, At: Direction.Left) {
            _isCropBoxResizingOver[Direction.Left.rawValue] = true
        }
            
        else if isThis(mousePoint, At: Direction.Right) {
            _isCropBoxResizingOver[Direction.Right.rawValue] = true
        }
        
        if isThis(mousePoint, At: Direction.Down) {
            _isCropBoxResizingOver[Direction.Down.rawValue] = true
        }
        else if isThis(mousePoint, At: Direction.Up) {
            _isCropBoxResizingOver[Direction.Up.rawValue] = true
        }
        
        if _isCropBoxResizingOver[Direction.Left.rawValue] && _isCropBoxResizingOver[Direction.Up.rawValue] {
            northWestSouthEastCursor.set()
        }
        else if _isCropBoxResizingOver[Direction.Left.rawValue] && _isCropBoxResizingOver[Direction.Down.rawValue] {
            northEastSouthWestCursor.set()
        }
        else if _isCropBoxResizingOver[Direction.Right.rawValue] && _isCropBoxResizingOver[Direction.Up.rawValue] {
            northEastSouthWestCursor.set()
        }
        else if _isCropBoxResizingOver[Direction.Right.rawValue] && _isCropBoxResizingOver[Direction.Down.rawValue] {
            northWestSouthEastCursor.set()
        }
        else if _isCropBoxResizingOver[Direction.Left.rawValue] {
            NSCursor.resizeLeftRightCursor().set()
        }
        else if _isCropBoxResizingOver[Direction.Right.rawValue] {
            NSCursor.resizeLeftRightCursor().set()
        }
        else if _isCropBoxResizingOver[Direction.Up.rawValue] {
            NSCursor.resizeUpDownCursor().set()
        }
        else if _isCropBoxResizingOver[Direction.Down.rawValue] {
            NSCursor.resizeUpDownCursor().set()
        }
        else {
            NSCursor.arrowCursor().set()
        }
    }
}




























