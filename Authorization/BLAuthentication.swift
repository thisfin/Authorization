//
//  BLAuthentication.swift
//  Authorization
//
//  Created by wenyou on 2017/4/20.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa

class BLAuthentication: NSObject {
    var authorizationRef: AuthorizationRef?
    var delegate: BLAuthenticationDelegate?

    private static let selfInstance = BLAuthentication()

    public static var sharedInstance: BLAuthentication {
        return selfInstance
    }

    override init() {
        super.init()
    }

    func isAuthenticated(command: String) -> Bool {
        var item: AuthorizationItem
        var rights: AuthorizationRights
        var err: OSStatus = 0

        if let _ = authorizationRef {
            rights = AuthorizationRights.init(count: 0, items: nil)
//            err = AuthorizationCreate(&rights, nil, [], UnsafeMutablePointer<AuthorizationRef?>(authorizationRef))
            err = AuthorizationCreate(&rights, nil, [], &authorizationRef)
        }

        item = AuthorizationItem.init(name: kAuthorizationRightExecute,
                                      valueLength: command.characters.count,
                                      value: UnsafeMutableRawPointer(Unmanaged<NSString>.passUnretained(command as NSString).toOpaque()),
                                      flags: 0)
        var items = [item]
        rights = AuthorizationRights.init(count: 1, items: &items)

        var authorizedRights: UnsafeMutablePointer<AuthorizationRights>? = UnsafeMutablePointer<AuthorizationRights>.allocate(capacity: MemoryLayout.size(ofValue: AuthorizationRights()))

        err = AuthorizationCopyRights(authorizationRef!, &rights, nil, [.extendRights], pointFromAddress(&authorizedRights))
        let authorized = (errAuthorizationSuccess == err)
        if authorized {
            AuthorizationFreeItemSet(authorizedRights!)
        }
        return authorized
    }

    func fetchPassword(command: String) -> Bool {
        var item: AuthorizationItem
        var rights: AuthorizationRights
        var err: OSStatus = 0

        if let _ = authorizationRef {
            rights = AuthorizationRights.init(count: 0, items: nil)
            //            err = AuthorizationCreate(&rights, nil, [], UnsafeMutablePointer<AuthorizationRef?>(authorizationRef))
            err = AuthorizationCreate(&rights, nil, [], &authorizationRef)
        }

        item = AuthorizationItem.init(name: kAuthorizationRightExecute,
                                      valueLength: command.characters.count,
                                      value: UnsafeMutableRawPointer(Unmanaged<NSString>.passUnretained(command as NSString).toOpaque()),
                                      flags: 0)
        var items = [item]
        rights = AuthorizationRights.init(count: 1, items: &items)

        var authorizedRights: UnsafeMutablePointer<AuthorizationRights>? = UnsafeMutablePointer<AuthorizationRights>.allocate(capacity: MemoryLayout.size(ofValue: AuthorizationRights()))

        err = AuthorizationCopyRights(authorizationRef!, &rights, nil, [.extendRights, .interactionAllowed], pointFromAddress(&authorizedRights))
        let authorized = (errAuthorizationSuccess == err)
        if authorized {
            AuthorizationFreeItemSet(authorizedRights!)
            if let _ = delegate {
                delegate?.authenticationDidAuthorize(authentication: self)
            }
        }
        return authorized
    }

    func authenticate(command: String) -> Bool {
        if !self.isAuthenticated(command: command) {
            _ = self.fetchPassword(command: command)
        }
        return self.isAuthenticated(command: command)
    }

    func deauthenticate() {
        if let _ = authorizationRef {
            AuthorizationFree(authorizationRef!, [.destroyRights])
            authorizationRef = nil
            if let _ = delegate {
                delegate?.authenticationDidDeauthorize(authentication: self)
            }
        }
    }

    private func pointFromAddress<T>(_ p: UnsafeMutablePointer<T>?) -> UnsafeMutablePointer<T>? {
        return p
    }
}

protocol BLAuthenticationDelegate {
    func authenticationDidAuthorize(authentication: BLAuthentication)
    func authenticationDidDeauthorize(authentication: BLAuthentication)
    func authenticationDidExecute(authentication: BLAuthentication)
    func authenticationFailedExecute(authentication: BLAuthentication)
    func authenticationDidKill(authentication: BLAuthentication)
    func authenticationFailedKill(authentication: BLAuthentication)
}
