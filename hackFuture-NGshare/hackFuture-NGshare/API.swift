//
//  API.swift
//  hackFuture-NGshare
//
//  Created by 寺澤悠翔 on 2019/12/15.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import Foundation
import UIKit
import kintone_ios_sdk
import Promises


let kintoneAuth = Auth()
var conn:Connection? = nil
var app:App? = nil
let query = "レコード番号 >= 2 order by レコード番号 asc"
let apitoken = "bGIfUIxeHvnblXzhaVtE2LF8zhSJQoVlY6wWWUKV"
let domain = "https://devvzqhyi.cybozu.com"
let appID = 1

    func testGetRecord() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("test start")
        
        
        // Init authenticationAuth
        kintoneAuth.setApiToken(apitoken)
        
        // Init Connection without "guest space ID"
        let kintoneConnection = Connection(domain, kintoneAuth)
        
        // Init Record Module
        let kintoneRecord = Record(kintoneConnection)
        
        // execute get record API
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

func multiGetRecords(){
    // Init authenticationAuth
    kintoneAuth.setApiToken(apitoken)
    
    // Init Connection without "guest space ID"
    let kintoneConnection = Connection(domain, kintoneAuth)
    
    // Init Record Module
    let kintoneRecord = Record(kintoneConnection)
    kintoneRecord.getRecords(appID, query, nil, true).then{response in
        let records = response.getRecords()
        
        for (i, dval) in (records?.enumerated())! {
            for (code, value) in dval {
                print(value.getType())
                print(value.getValue())
            }
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
