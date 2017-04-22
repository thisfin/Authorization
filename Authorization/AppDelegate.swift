//
//  AppDelegate.swift
//  Authorization
//
//  Created by wenyou on 2017/4/19.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa
import SecurityInterface

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    static let windowSize = NSMakeSize(800, 500)
    var window: NSWindow!
    var authView: SFAuthorizationView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let item: AuthorizationItem = AuthorizationItem.init(name: kAuthorizationRightExecute, valueLength: 0, value: nil, flags: 0)
        var items: [AuthorizationItem] = [item]
        var rights: AuthorizationRights = AuthorizationRights.init(count: 1, items: &items)

        authView = SFAuthorizationView.init(frame: CGRect.init(origin: NSMakePoint(20, -20), size: AppDelegate.windowSize))
        authView.setAuthorizationRights(&rights)
        authView.setDelegate(self)
        authView.updateStatus(nil)

        window = TextWindow(contentRect: NSRect.zero,
                            styleMask: [.closable, .resizable, .miniaturizable, .titled],
                            backing: .buffered,
                            defer: false)
        window.center()
        window.makeKeyAndOrderFront(self)

        NSLog("\(BLAuthentication.sharedInstance.isAuthenticated(command: "ls /.Spotlight-V100/"))")
        NSLog("\(BLAuthentication.sharedInstance.authenticate(command: "ls /.Spotlight-V100/"))")
        NSLog("\(BLAuthentication.sharedInstance.isAuthenticated(command: "ls /.Spotlight-V100/"))")
//        window.contentView?.addSubview(authView)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    // MARK: - SFAuthorizationViewDelegate
    override func authorizationViewDidAuthorize(_ view: SFAuthorizationView!) {
        NSLog("authorizationViewDidAuthorize")
    }

    override func authorizationViewDidDeauthorize(_ view: SFAuthorizationView!) {
        NSLog("authorizationViewDidDeauthorize")
    }

    override func authorizationViewShouldDeauthorize(_ view: SFAuthorizationView!) -> Bool {
        NSLog("authorizationViewShouldDeauthorize")
        return true
    }

    override func authorizationViewCreatedAuthorization(_ view: SFAuthorizationView!) {
        NSLog("authorizationViewCreatedAuthorization")
    }

    override func authorizationViewReleasedAuthorization(_ view: SFAuthorizationView!) {
        NSLog("authorizationViewReleasedAuthorization")
    }

    override func authorizationViewDidHide(_ view: SFAuthorizationView!) {
        NSLog("authorizationViewDidHide")
    }
}

