//
//  GoodsInfoViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit

class GoodsInfoViewController: UIViewController, UITextFieldDelegate {
    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.goodsNameTextField.delegate = self
        self.goodsConditionTextField.delegate = self
        self.goodsPriceTextField.delegate = self
        self.goodsPlaceTextField.delegate = self
        self.goodsCommentTextField.delegate = self
        
        //文字列の初期化
        goodsNameTextField.text = ""
        goodsConditionTextField.text = ""
        goodsPriceTextField.text = ""
        goodsPlaceTextField.text = ""
        goodsCommentTextField.text = ""
        
        //kintoneから情報を取ってくる
    }
    
    /* アウトレット */
    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goodsNameTextField: UITextField!
    @IBOutlet weak var goodsConditionTextField: UITextField!
    @IBOutlet weak var goodsPriceTextField: UITextField!
    @IBOutlet weak var goodsPlaceTextField: UITextField!
    @IBOutlet weak var goodsCommentTextField: UITextField!
    
    
    /* アクション */
    
    
    /* プロパティ */
    //登録する商品の情報
    var goods = GoodsInfo(image: "", name: "", condition: "", price: 0, place: "", comment: "")
    
    
    /* メソッド */
    //リターンキーが押された時
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.tag == 1){ //名前欄
            goodsNameTextField.resignFirstResponder()
            goods.name =  goodsNameTextField.text!
        }
        if(textField.tag == 2){ //状態欄
            goodsConditionTextField.resignFirstResponder()
            goods.condition = goodsConditionTextField.text!
        }
        if(textField.tag == 3){ //値段欄
            goodsPriceTextField.resignFirstResponder()
            goods.price = Int(goodsPriceTextField.text!)!
        }
        if(textField.tag == 4){ //取引場所欄
            goodsPlaceTextField.resignFirstResponder()
            goods.place = goodsPlaceTextField.text!
        }
        if(textField.tag == 5){ //取引場所欄
            goodsCommentTextField.resignFirstResponder()
            goods.comment = goodsCommentTextField.text!
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
