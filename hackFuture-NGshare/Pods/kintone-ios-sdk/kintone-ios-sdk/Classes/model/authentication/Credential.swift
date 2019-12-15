//
//  Credential.swift
//  kintone-ios-sdk
//
//  Created by t000572 on 2018/09/05.
//  Copyright © 2018年 y001112. All rights reserved.
//

open class Credential: NSObject {
    
    private var username: String
    private var password: String

    init(_ username: String, _ password: String) {
        self.username = username
        self.password = password
    }

    /// get the login name
    ///
    /// - Returns: the login name
    open func getUsername() -> String {
        return self.username
    }

    /// get the login password
    ///
    /// - Returns: the login password
    open func getPassword() -> String {
        return self.password
    }

}
