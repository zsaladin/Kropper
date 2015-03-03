//
//  SizeInputViewController.swift
//  Kropper
//
//  Created by zsaladin on 2015. 3. 4..
//  Copyright (c) 2015년 zsaladin. All rights reserved.
//

import Cocoa

class SizeInputViewController: NSViewController {
    
    @IBOutlet weak var _widthTextField: NSTextField!
    @IBOutlet weak var _heightTextField: NSTextField!
    
    var _executer: SizeInputExecuter! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        Global.SizeInputViewControllerInstance = self
    }
    
    
    @IBAction func execute(sender: AnyObject) {
        _executer._size = NSSize(width: _widthTextField.stringValue.toInt()!, height: _heightTextField.stringValue.toInt()!)
        _executer.execute()
        self.dismissViewController(self)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewController(self)
    }
    
}
