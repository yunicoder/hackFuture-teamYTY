//
//  ChatViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "取引画面"
        self.view.backgroundColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1.0) // 背景色
        
        let pur = PurchaseViewController() // 線を引くためにpurchaseを委譲
        // pur.writeBorder(layer: self.line1.layer) // 線を引く
        // pur.writeBorder(layer: self.line2.layer) // 線を引く
        
        GoodsInfoView.layer.borderWidth = 1.0    // 枠線の幅
        GoodsInfoView.layer.borderColor = UIColor.gray.cgColor // 枠線の色
        
        // 画面に値を表示
        goodsImagetext.image = PicDataToUIImage(picData: recieveGoodsInfo!.image) // 画像
        goodsNameText.text = recieveGoodsInfo?.name // 名前
        goodsConditionText.text = recieveGoodsInfo?.condition // 状態
        goodsPriceText.text = recieveGoodsInfo?.price // 価格
        
        timeText.text = recieveGoodsInfo!.time + "に" // 時間
        placeText.text = recieveGoodsInfo!.place + "へ行ってください" // 場所
    }
    
    // 送られてくるデータ
    var recieveGoodsInfo:GoodsInfo?
    
    /* アウトレット */
    @IBOutlet weak var GoodsInfoView: UIView! // 商品情報をのせるビュー
    @IBOutlet weak var timeText: UILabel! // 時間
    @IBOutlet weak var placeText: UILabel! // 場所
    @IBOutlet weak var goodsImagetext: UIImageView! // 商品写真
    @IBOutlet weak var goodsNameText: UILabel! //名前
    @IBOutlet weak var goodsConditionText: UILabel! // 状態
    @IBOutlet weak var goodsPriceText: UILabel! // 価格
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    
    
    /* アクション */
    //受け取り完了ボタンを押したら
    @IBAction func completeButtonTapped(_ sender: UIButton) {
    }
}
