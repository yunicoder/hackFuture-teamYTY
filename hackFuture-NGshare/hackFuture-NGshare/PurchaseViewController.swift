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
        
        //タイトル変更
        navigationItem.title = "購入画面"
        
        //kintoneからデータを持ってくる
    }
    
    /* アウトレット */
    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goodsNameText: UILabel!
    @IBOutlet weak var goodsConditionText: UILabel!
    @IBOutlet weak var goodsPriceText: UILabel!
    @IBOutlet weak var goodsPlaceText: UILabel!
    @IBOutlet weak var goodsCommentText: UILabel!
    
    
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
