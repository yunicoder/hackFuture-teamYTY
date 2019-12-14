//
//  PurchaseViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit


//商品状態の構造体
struct GoodsInfo{
    var image : UIImage //商品の画像名
    var name : String //商品の名前
    var condition : String //商品の状態
    var price : Int //商品の値段
    var place : String //やりとり場所
    var comment : String //コメント
}


class PurchaseViewController: UIViewController, UITextFieldDelegate {
    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /* アウトレット */
    
    
    
    /* アクション */
    //登録ボタン押したとき
    //kintoneにデータを保存
    
    
}
