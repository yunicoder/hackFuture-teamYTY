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
        
        //タイトル変更
        navigationItem.title = "出品画面"
        
        //背景色の変更
        view.backgroundColor = UIColor(red: 178/255, green: 255/255, blue: 101/255, alpha: 1.0)
        
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
    }
    
    /* アウトレット */
    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goodsNameTextField: UITextField!
    @IBOutlet weak var goodsConditionTextField: UITextField!
    @IBOutlet weak var goodsPriceTextField: UITextField!
    @IBOutlet weak var goodsPlaceTextField: UITextField!
    @IBOutlet weak var goodsCommentTextField: UITextField!
    
    
    /* アクション */
    //登録ボタン
    //kintoneに情報投げる
    
    
    /* プロパティ */
    //登録する商品の情報
    var goods = GoodsInfo(image: "", name: "", condition: "", price: 0, place: "", comment: "")
    
    
    /* メソッド */
    //リターンキーが押された時
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //改行
        if(textField.tag == 1){ //名前欄
            goods.name = textField.text!
        }
        if(textField.tag == 2){ //状態欄
            goods.condition = textField.text!
        }
        if(textField.tag == 3){ //値段欄
            goods.price = Int(textField.text!)!
        }
        if(textField.tag == 4){ //取引場所欄
            goods.place = textField.text!
        }
        if(textField.tag == 5){ //取引場所欄
            goods.comment = textField.text!
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
