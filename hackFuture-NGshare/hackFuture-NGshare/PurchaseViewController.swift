//
//  PurchaseViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit


class PurchaseViewController: UIViewController, UITextFieldDelegate {
    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //タイトル変更
        navigationItem.title = "購入画面"
        self.contentView.backgroundColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1.0)
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
        self.line7.layer.borderWidth = 2.0    // 枠線の幅
        self.line7.layer.borderColor = UIColor.gray.cgColor
        self.line8.layer.borderWidth = 2.0    // 枠線の幅
        self.line8.layer.borderColor = UIColor.gray.cgColor
        
        // 受けったデータをラベルに書き込む
        
        // 写真を表示
        if let decodedData = Data(base64Encoded: recieveGoodsInfo!.image , options: Data.Base64DecodingOptions.ignoreUnknownCharacters){ // based64の文字列をdata型に変換してそれがnilではない時、つまり写真データがある時
            let decodedImage = UIImage(data: decodedData as Data) // dataをUIImageに変換
            goodsImage.image = decodedImage // 写真を表示
        }
        else{ // 写真データがない、もしくは変換できない時
            goodsImage.image = UIImage(named: "noImage") // noImageと表示
        }
        
        goodsNameText.text = recieveGoodsInfo?.name // 商品名を表示
        goodsConditionText.text = recieveGoodsInfo?.condition // 商品状態を表示
        goodsPriceText.text = String(recieveGoodsInfo!.price) // 商品価格を表示
        //goodsPlaceText.text = recieveGoodsInfo?.place
        goodsTimeText.text = recieveGoodsInfo?.time // 取引時間を表示
        //featureText.text = recieveGoodsInfo?.feature
        goodsCommentText.text = recieveGoodsInfo?.comment // 商品のコメントを表示
    }
    
    // 送られてくるデータ
    var recieveGoodsInfo:GoodsInfo?
    
    /* アウトレット */
    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goodsNameText: UILabel!
    @IBOutlet weak var goodsConditionText: UILabel!
    @IBOutlet weak var goodsPriceText: UILabel!
    @IBOutlet weak var goodsPlaceText: UILabel!
    @IBOutlet weak var goodsTimeText: UILabel!
    @IBOutlet weak var featureText: UILabel!
    @IBOutlet weak var goodsCommentText: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var line5: UIView!
    @IBOutlet weak var line6: UIView!
    @IBOutlet weak var line7: UIView!
    @IBOutlet weak var line8: UIView!
    
    
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
