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
    var watch: WYFileWatch!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        /*
        // 人肉加权
        let item: AuthorizationItem = AuthorizationItem.init(name: kAuthorizationRightExecute, valueLength: 0, value: nil, flags: 0)
        var items: [AuthorizationItem] = [item]
        var rights: AuthorizationRights = AuthorizationRights.init(count: 1, items: &items)

        authView = SFAuthorizationView.init(frame: CGRect.init(origin: NSMakePoint(20, -20), size: AppDelegate.windowSize))
        authView.setAuthorizationRights(&rights)
        authView.setDelegate(self)
        authView.updateStatus(nil)
         */

        window = TextWindow(contentRect: NSRect.zero,
                            styleMask: [.closable, .resizable, .miniaturizable, .titled],
                            backing: .buffered,
                            defer: false)
        window.center()
        window.makeKeyAndOrderFront(self)
        // 人肉加权
        // window.contentView?.addSubview(authView)

        // 监控文件变化 watch对象需要长期持有
//        let tmpfile = URL(fileURLWithPath: "~/b.txt")
//        let tmpfile = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.autosavedInformationDirectory, .userDomainMask, true).first! + "b.txt")
        let tmpfile = URL.init(fileURLWithPath: NSHomeDirectory() + "/a.txt")
        watch = try! WYFileWatch.init(paths: [tmpfile.path], createFlag: [.UseCFTypes, .FileEvents],/*, .IgnoreSelf, .NoDefer],*/ runLoop: RunLoop.current, latency: 1, eventHandler: { (event) in
            NSLog("\(event.path) \(event.flag) \(event.eventID)")
        })

        // 加权测试
        /*
        NSLog("\(WYAuthentication.sharedInstance.isAuthenticated("ls /.Spotlight-V100/"))")
        NSLog("\(WYAuthentication.sharedInstance.authenticate("ls /.Spotlight-V100/"))")
        WYAuthentication.sharedInstance.deauthenticate()
        NSLog("\(WYAuthentication.sharedInstance.isAuthenticated("ls /.Spotlight-V100/"))")
        */
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

