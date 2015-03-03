//
//  AppDelegate.swift
//  Kropper
//
//  Created by zsaladin on 2015. 3. 4..
//  Copyright (c) 2015년 zsaladin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func instantiateSizeInputViewControllerIfNotExist() {
        if Global.SizeInputViewControllerInstance == nil {
            Global.SizeInputViewControllerInstance =
                Global.ViewControllerInstance.storyboard!.instantiateControllerWithIdentifier("SizeInput")
                as SizeInputViewController
        }
    }
    
    @IBAction func openFile(sender: AnyObject) {
        var openDialog = NSOpenPanel()
        openDialog.canChooseFiles = true
        if openDialog.runModal() == NSOKButton {
            Global.ViewControllerInstance.importImage(openDialog.URL!.path!)
        }
    }
    
    @IBAction func saveFile(sender: AnyObject) {
        var saveDialog = NSSavePanel()
        if saveDialog.runModal() == NSOKButton {
            Global.ViewControllerInstance.exportImage(saveDialog.URL!.path!)
        }
    }
    
    @IBAction func scale(sender: AnyObject) {
        instantiateSizeInputViewControllerIfNotExist()
        Global.SizeInputViewControllerInstance._executer = ScaleExecutor()
        Global.ViewControllerInstance.presentViewControllerAsSheet(Global.SizeInputViewControllerInstance)
    }
    
    @IBAction func crop(sender: AnyObject) {
        Global.ViewControllerInstance.crop()
    }
    
    @IBAction func resize(sender: AnyObject) {
        instantiateSizeInputViewControllerIfNotExist()
        Global.SizeInputViewControllerInstance._executer = ResizeExecuter()
        Global.ViewControllerInstance.presentViewControllerAsSheet(Global.SizeInputViewControllerInstance)
    }
    
    
    @IBAction func createKropBox(sender: AnyObject) {
        instantiateSizeInputViewControllerIfNotExist()
        Global.SizeInputViewControllerInstance._executer = KropBoxExecuter()
        Global.ViewControllerInstance.presentViewControllerAsSheet(Global.SizeInputViewControllerInstance)
    }
}


