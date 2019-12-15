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
// Init Connection without "guest space ID"
let connection = Connection(domain, kintoneAuth)

  // Init Record Module
let recordManagement = Record(connection)
let query = "レコード番号 >= 3 order by レコード番号 asc"

let apitoken = "bGIfUIxeHvnblXzhaVtE2LF8zhSJQoVlY6wWWUKV"
//let apitoken = "qfeTYjpsATHjIjnKOiPp3T8xsAKfthKEsAX0LhkI"
let domain = "https://devvzqhyi.cybozu.com"
let appID = 1
//let appID = 3

    func testGetRecord() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("test start")
        
        
        // Init authenticationAuth
        kintoneAuth.setApiToken(apitoken)
        
        
        // execute get record API
        let recordID = 1
        recordManagement.getRecord(appID, recordID).then{response in
            
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

/*
func multiGetRecords()-> [GoodsInfo]{
    var goods : [GoodsInfo] = []
    // Init authenticationAuth
    kintoneAuth.setApiToken(apitoken)
    recordManagement.getRecords(appID, query, nil, true).then{response in
        let records = response.getRecords()
        for (i, dval) in (records?.enumerated())! {
            //print(dval)
            for (code, value) in dval {
                print(code)
                switch code {
                case "image":
                    goods[i].image = value.getValue() as! UIImage
                case "name":
                    goods[i].name = value.getValue() as! String
                case "price":
                    goods[i].price = value.getValue() as! Int
                case "place":
                    goods[i].place = value.getValue() as! String
                case "see_time":
                    goods[i].time = value.getValue() as! String
                case "coment":
                    goods[i].comment = value.getValue() as! String
                case "future":
                    goods[i].feature = value.getValue() as! String
                case "condition":
                    goods[i].condition = value.getValue() as! String
                default:
                    //goods[i].comment = "error"
                    break
                }
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
    return goods
}
 */
    
func addRecord(image:Data,name:String,condition:String,price:String,place:String,coment:String,future:String){
        var addData: Dictionary = [String:AnyObject]()
        var field = FieldValue()
        field.setType(FieldType.FILE)
        field.setValue(image)
        addData["image"] = field
        var field1 = FieldValue()
        field1.setType(FieldType.SINGLE_LINE_TEXT)
        field1.setValue(name)
        addData["name"] = field1
        var field2 = FieldValue()
        field2.setType(FieldType.SINGLE_LINE_TEXT)
        field2.setValue(condition)
        addData["condition"] = field2
        var field3 = FieldValue()
        field3.setType(FieldType.SINGLE_LINE_TEXT)
        field3.setValue(price)
        addData["price"] = field3
        var field4 = FieldValue()
        field4.setType(FieldType.SINGLE_LINE_TEXT)
        field4.setValue(place)
        addData["place"] = field4
        var field5 = FieldValue()
        field5.setType(FieldType.MULTI_LINE_TEXT)
        field5.setValue(coment)
        addData["coment"] = field5
        var field6 = FieldValue()
        field6.setType(FieldType.MULTI_LINE_TEXT)
        field6.setValue(future)
        addData["future"] = field6
            // Init authenticationAuth
        kintoneAuth.setApiToken(apitoken)
                  
    
            
        recordManagement.addRecord(appID, addData as! [String : FieldValue]).then{response in
            print(response.getId())
            print(response.getRevision())
        }.catch{ error in
            if error is KintoneAPIException {
                print((error as! KintoneAPIException).toString()!)
            }
            else {
                print((error as! Error).localizedDescription)
            }
        }
      
}

