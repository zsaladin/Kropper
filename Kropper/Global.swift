//
//  Global.swift
//  Kropper
//
//  Created by zsaladin on 2015. 3. 4..
//  Copyright (c) 2015년 zsaladin. All rights reserved.
//

import Foundation
import Cocoa

class Global {
    private struct ViewControllerStruct { static var staticVariable: ViewController? = nil }
    
    class var ViewControllerInstance: ViewController! {
        get { return ViewControllerStruct.staticVariable! }
        set { ViewControllerStruct.staticVariable = newValue }
    }
    
    private struct SizeInputViewControllerStruct { static var staticVariable: SizeInputViewController? = nil }
    
    class var SizeInputViewControllerInstance: SizeInputViewController! {
        get { return SizeInputViewControllerStruct.staticVariable }
        set { SizeInputViewControllerStruct.staticVariable = newValue }
    }
    
    var imagePath: String! = nil
    
    private struct GlobalStruct { static var staticeVariable: Global! = nil }
    class var Instance: Global {
        get {
            if GlobalStruct.staticeVariable == nil {
                GlobalStruct.staticeVariable = Global()
            }
            return GlobalStruct.staticeVariable
        }
    }
}

enum Direction : Int {
    case Up, Down, Left, Right, UpLeft, UpRight, DownLeft, DownRight
};

var sensetive: CGFloat = 3


var northEastSouthWestCursorName = "resizenortheastsouthwest";
var northEastSouthWestCursorPath = "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/HIServices.framework/Versions/A/Resources/cursors/" + northEastSouthWestCursorName

var northEastSouthWestImage = NSImage(byReferencingFile: northEastSouthWestCursorPath + "/cursor.pdf")
var northEastSouthWestInfo = NSDictionary(contentsOfFile: northEastSouthWestCursorPath + "/info.plist")
var northEastSouthWestCursor = NSCursor(image: northEastSouthWestImage!, hotSpot: NSPoint(x: northEastSouthWestInfo!.valueForKey("hotx")!.doubleValue!, y: northEastSouthWestInfo!.valueForKey("hoty")!.doubleValue!))


var northWestSouthEastCursorName = "resizenorthwestsoutheast";
var northWestSouthEastCursorPath = "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/HIServices.framework/Versions/A/Resources/cursors/" + northWestSouthEastCursorName

var northWestSouthEastImage = NSImage(byReferencingFile: northWestSouthEastCursorPath + "/cursor.pdf")
var northWestSouthEastInfo = NSDictionary(contentsOfFile: northWestSouthEastCursorPath + "/info.plist")
var northWestSouthEastCursor = NSCursor(image: northWestSouthEastImage!, hotSpot: NSPoint(x: northWestSouthEastInfo!.valueForKey("hotx")!.doubleValue!, y: northWestSouthEastInfo!.valueForKey("hoty")!.doubleValue!))

