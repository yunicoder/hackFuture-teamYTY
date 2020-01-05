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

typealias CompletionClosure = ((_ result:[GoodsInfo]) -> Void)

func multiGetRecords(completionClosure:@escaping (_ result:[GoodsInfo]) -> Void){
    var resGoods = [GoodsInfo]() // kintoneから読み込んで最後にresultとして返す値(responseGoodsの略)
    // Init authenticationAuth
    kintoneAuth.setApiToken(apitoken)
    recordManagement.getRecords(appID, query, nil, true).then{response in
        let records = response.getRecords()
        for (i, dval) in (records?.enumerated())! {
            resGoods.append(GoodsInfo.init()) // resGoodsの初期化
            //print(dval)
            for (code, value) in dval {
                //print("code:\(code)")
                //print("value.getValue:\(value.getValue()!)")
                switch code {
                case "image":
                    break
                    //resGoods[i].image = value.getValue() as! String
                case "name":
                    resGoods[i].name = value.getValue()! as! String
                case "price":
                    resGoods[i].price = value.getValue()! as! String
                case "place":
                    resGoods[i].place = value.getValue()! as! String
                case "see_time":
                    resGoods[i].time = value.getValue()! as! String
                case "coment":
                    resGoods[i].comment = value.getValue()! as! String
                case "future":
                    resGoods[i].feature = value.getValue()! as! String
                case "condition":
                    resGoods[i].condition = value.getValue()! as! String
                default:
                    //resGoods[i].comment = "error"
                    break
                }
            }
            //print("goodsByFor:\(resGoods)")
        }
        completionClosure(resGoods) // クロージャーを終了させる(resultに値が入る)
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error).localizedDescription)
        }
    }
}


// kintoneの保存するデータの型が以下であることに注意
// image:Data,name:String,condition:String,price:String,place:String,coment:String,future:String
func addRecord(addedGoods: GoodsInfo){
    var addData: Dictionary = [String:AnyObject]()
    
    var imageField = FieldValue()
    imageField.setType(FieldType.FILE)
    // imageField.setValue(addedGoods.image)
    // addData["image"] = imageField // データの型を後で考えよう
    
    var nameField = FieldValue()
    nameField.setType(FieldType.SINGLE_LINE_TEXT)
    nameField.setValue(addedGoods.name)
    addData["name"] = nameField
    
    var conditonField = FieldValue()
    conditonField.setType(FieldType.SINGLE_LINE_TEXT)
    conditonField.setValue(addedGoods.condition)
    addData["condition"] = conditonField
    
    var priceField = FieldValue()
    priceField.setType(FieldType.SINGLE_LINE_TEXT)
    priceField.setValue(addedGoods.price)
    addData["price"] = priceField
    
    var placeField = FieldValue()
    placeField.setType(FieldType.SINGLE_LINE_TEXT)
    placeField.setValue(addedGoods.place)
    addData["place"] = placeField
    
    var commentField = FieldValue()
    commentField.setType(FieldType.MULTI_LINE_TEXT)
    commentField.setValue(addedGoods.comment)
    addData["coment"] = commentField
    
    var featureField = FieldValue()
    featureField.setType(FieldType.MULTI_LINE_TEXT)
    featureField.setValue(addedGoods.feature)
    addData["future"] = featureField
    
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

