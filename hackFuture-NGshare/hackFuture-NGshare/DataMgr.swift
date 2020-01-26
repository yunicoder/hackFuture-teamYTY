//
//  DataMgr.swift
//  hackFuture-NGshare
//
//  Created by Takuma Yabe on 2019/12/23.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//
// データ関連の型(変数)と関数の宣言ファイル

import Foundation
import UIKit

/*--------
 構造体と変数の宣言
----------*/
//商品状態の構造体
struct GoodsInfo : Codable{
    var image : String //商品の画像名。保存したキー
    var name : String //商品の名前
    var condition : String //商品の状態
    var price : String //商品の値段
    var place : String //やりとり場所
    var time : String //やりとり時間
    var feature : String //自分の特徴
    var comment : String //コメント
}
// イニシャライザ
extension GoodsInfo{
    init(){
        image = "noImage"
        name = "noName"
        condition = "noCondition"
        price = "-1"
        place = "noPlace"
        time = "noTime"
        feature = "noFeature"
        comment = "noComment"
    }
}



/*--------
 関数の宣言
 --------*/

// URLから画像を生成する関数
func getImageByUrl(url: String) -> UIImage{
    let url = URL(string: url)
    do {
        let data = try Data(contentsOf: url!)
        return UIImage(data: data)!
    } catch let err {
        print("Error : \(err.localizedDescription)")
    }
    return UIImage()
}

