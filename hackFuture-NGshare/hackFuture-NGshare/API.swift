//
//  API.swift
//  hackFuture-NGshare
//
//  Created by 寺澤悠翔 on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit
import kintone_ios_sdk
import Promises


let auth:Auth = Auth()
var conn:Connection? = nil
var app:App? = nil

func testGetRecord() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    print("test start")
    
    let apitoken = "bGIfUIxeHvnblXzhaVtE2LF8zhSJQoVlY6wWWUKV"
    let domain = "https://devvzqhyi.cybozu.com"
    
    // Init authenticationAuth
    let kintoneAuth = Auth()
    kintoneAuth.setApiToken(apitoken)
    
    // Init Connection without "guest space ID"
    let kintoneConnection = Connection(domain, kintoneAuth)
    
    // Init Record Module
    let kintoneRecord = Record(kintoneConnection)
    
    // execute get record API
    let appID = 1
    let recordID = 1
    kintoneRecord.getRecord(appID, recordID).then{response in
        
        let resultData: Dictionary = response.getRecord()!
        print(resultData["$id"]?.getValue())
        
        for (code, value) in resultData {
            print(value.getType()!)
            print(value.getValue())
        }
        }.catch{ error in
            if error is KintoneAPIException {
                print((error as! KintoneAPIException).toString()!)
            }
            else {
                print((error as! Error).localizedDescription)
            }
    }
}


