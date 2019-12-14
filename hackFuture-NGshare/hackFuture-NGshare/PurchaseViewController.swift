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
    var time : String //取引をする時間
    var feature : String //自分の特徴
    var comment : String //コメント
}


class PurchaseViewController: UIViewController, UITextFieldDelegate {
    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //タイトル変更
        navigationItem.title = "購入画面"
        view.backgroundColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1.0)
        self.line1.layer.borderWidth = 2.0    // 枠線の幅
        self.line1.layer.borderColor = UIColor.gray.cgColor
        self.line2.layer.borderWidth = 2.0    // 枠線の幅
        self.line2.layer.borderColor = UIColor.gray.cgColor
        self.line3.layer.borderWidth = 2.0    // 枠線の幅
        self.line3.layer.borderColor = UIColor.gray.cgColor
        self.line4.layer.borderWidth = 2.0    // 枠線の幅
        self.line4.layer.borderColor = UIColor.gray.cgColor
        self.line5.layer.borderWidth = 2.0    // 枠線の幅
        self.line5.layer.borderColor = UIColor.gray.cgColor
        self.line6.layer.borderWidth = 2.0    // 枠線の幅
        self.line6.layer.borderColor = UIColor.gray.cgColor
        
        //kintoneからデータを持ってくる
    }
    
    /* アウトレット */
    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goodsNameText: UILabel!
    @IBOutlet weak var goodsConditionText: UILabel!
    @IBOutlet weak var goodsPriceText: UILabel!
    @IBOutlet weak var goodsPlaceText: UILabel!
    @IBOutlet weak var goodsCommentText: UILabel!
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var line5: UIView!
    @IBOutlet weak var line6: UIView!
    
    
    
    /* アクション */
    //購入ボタンを押したとき
    @IBAction func purchaseButtonTapped(_ sender: UIButton) {
        //アラートを表示する↓＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
        let alert: UIAlertController = UIAlertController(title: "注意", message: "この商品を購入しますか？", preferredStyle: .actionSheet)
        let canselAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
                print("キャンセル")
        }
        let okAction: UIAlertAction = UIAlertAction(title: "購入", style: .destructive) { (UIAlertAction) in
                self.performSegue(withIdentifier: "ToChatView", sender: nil)
        }
        //アラートに設定を反映させる
        alert.addAction(canselAction)
        alert.addAction(okAction)
        //アラート画面を表示させる
        present(alert, animated: true, completion: nil)
    }
}
