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
        
        // レイアウト
        self.contentView.backgroundColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1.0) // 背景色
        writeBorder(layer: self.line1.layer) // 灰色の線を描画
        writeBorder(layer: self.line2.layer) // 灰色の線を描画
        writeBorder(layer: self.line3.layer) // 灰色の線を描画
        writeBorder(layer: self.line4.layer) // 灰色の線を描画
        writeBorder(layer: self.line5.layer) // 灰色の線を描画
        writeBorder(layer: self.line6.layer) // 灰色の線を描画
        writeBorder(layer: self.line7.layer) // 灰色の線を描画
        writeBorder(layer: self.line8.layer) // 灰色の線を描画
        
        commentsText.isEditable = false
        
        
        
        goodsImage.image = PicDataToUIImage(picData: recieveGoodsInfo!.image) // 写真を表示
        goodsNameText.text = recieveGoodsInfo?.name // 商品名を表示
        goodsConditionText.text = recieveGoodsInfo?.condition // 商品状態を表示
        goodsPriceText.text = String(recieveGoodsInfo!.price) // 商品価格を表示
        //goodsPlaceText.text = recieveGoodsInfo?.place
        goodsTimeText.text = recieveGoodsInfo?.time // 取引時間を表示
        //featureText.text = recieveGoodsInfo?.feature
        commentsText.text = recieveGoodsInfo?.comment // 商品のコメントを表示
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
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var commentsText: UITextView!
    
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
    
    //テキストビューが変更された
    func textViewDidChange(textView: UITextView) {
        print("textViewDidChange : \(textView.text)");
    }
    
    // テキストビューにフォーカスが移った
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        print("textViewShouldBeginEditing : \(textView.text)");
        return true
    }
    
    // テキストビューからフォーカスが失われた
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        print("textViewShouldEndEditing : \(textView.text)");
        return true
    }
    
    // 枠線を描く
    func writeBorder(layer:CALayer){
        layer.borderWidth = 2.0    // 枠線の幅
        layer.borderColor = UIColor.gray.cgColor // 枠線の色
    }
    
    // セグエによる画面遷移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "ToChatView"){
            let nextController = segue.destination as! ChatViewController
            nextController.recieveGoodsInfo = recieveGoodsInfo // 商品情報をchatに送る
        }
        
    }
}
