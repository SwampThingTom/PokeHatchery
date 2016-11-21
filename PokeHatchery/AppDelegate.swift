//
//  AppDelegate.swift
//  PokeHatchery
//
//  Created by Thomas Aylesworth on 11/15/16.
//  Copyright © 2016 Thomas H Aylesworth. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var mainViewController: MainViewController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        window.contentView!.addSubview((mainViewController?.view)!)
        mainViewController?.view.frame = window.contentView!.bounds
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
}

