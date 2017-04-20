//
//  BLAuthentication.swift
//  Authorization
//
//  Created by wenyou on 2017/4/20.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa

class BLAuthentication: NSObject {
//    var authorizationRef: AuthorizationRef?
//    var delegate: BLAuthenticationDelegate?
//
//    private static let selfInstance = BLAuthentication()
//
//    public static var sharedInstance: BLAuthentication {
//        return selfInstance
//    }
//
//    override init() {
//        super.init()
//
////        authorizationRef = Null
////        delegate
//    }
//
////    deinit {
////
////    }
////
////    // Returns the delegate
////    - (id)delegate {
////    return _delegate;
////    }
////
////    // Sets the delegate
////    - (void)setDelegate:(id)delegate  {
////    _delegate = delegate;
////    }
////    // deauthenticates the user and deallocates memory
////    - (void)dealloc {
////    [self deauthenticate];
////    [super dealloc];
////    }
//
//    func isAuthenticated(command: String) -> Bool {
//        var item: AuthorizationItem
//        var rights: AuthorizationRights = AuthorizationRights()
//        var authorizedRights: AuthorizationRights = AuthorizationRights()
//        var flags: AuthorizationFlags
//        var err: OSStatus = 0
//
//        if let ref = authorizationRef {
//            rights.count = 0
//            rights.items = nil
//            flags = []
//            err = AuthorizationCreate(&rights, nil, flags, UnsafeMutablePointer<AuthorizationRef?>(ref))
//        }
//
//        var cmd: [CChar] = [CChar].init(repeating: 0, count: 1024)
//        _ = command.getCString(&cmd, maxLength: 1024, encoding: .utf8)
//
//        item.name = UnsafePointer<Int8>(kAuthorizationRightExecute)
//        item.value = UnsafeMutableRawPointer(Unmanaged<NSString>.passUnretained(command as NSString).toOpaque())
//        item.valueLength = command.characters.count
//        item.flags = 0
//
//        rights.count = 1
//        rights.items = UnsafeMutablePointer<AuthorizationItem?>(mutating: UnsafePointer<AuthorizationItem?>(item))
//
//        flags = [.extendRights]
//        err = AuthorizationCopyRights(authorizationRef!, &rights, nil, flags, &authorizedRights)
//
//        let authorized = (errAuthorizationSuccess == err)
//
//        if authorized {
//            AuthorizationFreeItemSet(authorizedRights)
//        }
//
//        return authorized
//    }
//
////    - (BOOL)isAuthenticated:(NSString *)forCommand {
////    AuthorizationItem items[1];
////    AuthorizationRights rights;
////    AuthorizationRights *authorizedRights;
////    AuthorizationFlags flags;
////
////    OSStatus err = 0;
////    BOOL authorized = NO;
////    int i = 0;
////
////    if(_authorizationRef == NULL) {
////    rights.count = 0;
////    rights.items = NULL;
////
////    flags = kAuthorizationFlagDefaults;
////    err = AuthorizationCreate(&rights, kAuthorizationEmptyEnvironment, flags, &_authorizationRef);
////    }
////
////    char *command = malloc(sizeof(char) * 1024);
////    [forCommand getCString:command maxLength:1024];
////    items[0].name = kAuthorizationRightExecute;
////    items[0].value = command;
////    items[0].valueLength = strlen(command);
////    items[0].flags = 0;
////
////    rights.count = 1;
////    rights.items = items;
////
////    flags = kAuthorizationFlagExtendRights;
////
////    err = AuthorizationCopyRights(_authorizationRef, &rights, kAuthorizationEmptyEnvironment, flags, &authorizedRights);
////
////    authorized = (errAuthorizationSuccess == err);
////
////    if(authorized) {
////    AuthorizationFreeItemSet(authorizedRights);
////    }
////    
////    return authorized;
////    }
}

protocol BLAuthenticationDelegate {
    func authenticationDidAuthorize(authentication: BLAuthentication)
    func authenticationDidDeauthorize(authentication: BLAuthentication)
    func authenticationDidExecute(authentication: BLAuthentication)
    func authenticationFailedExecute(authentication: BLAuthentication)
    func authenticationDidKill(authentication: BLAuthentication)
    func authenticationFailedKill(authentication: BLAuthentication)
}
