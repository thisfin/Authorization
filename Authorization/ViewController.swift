//
//  ViewController.swift
//  Authorization
//
//  Created by wenyou on 2017/4/19.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer?.backgroundColor = NSColor.white.cgColor
        view.frame = NSRect(origin: .zero, size: AppDelegate.windowSize)
    }
}
