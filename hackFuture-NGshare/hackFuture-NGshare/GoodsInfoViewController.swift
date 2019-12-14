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
        self.goodsTimeTextField.delegate = self
        self.featureTextField.delegate = self
        
        //文字列の初期化
        goodsNameTextField.text = ""
        goodsNameTextField.placeholder = "(例)モバイルバッテリー"
        goodsConditionTextField.text = ""
        goodsConditionTextField.placeholder = "(例)キズあり"
        goodsPriceTextField.text = ""
        goodsPriceTextField.placeholder = "(例)500"
        goodsPlaceTextField.text = ""
        goodsPlaceTextField.placeholder = "(例)3F◯◯の前"
        goodsCommentTextField.text = ""
        goodsCommentTextField.placeholder = "(例)使用感はあまりないです"
        goodsTimeTextField.text = ""
        goodsTimeTextField.placeholder = "(例)15時"
        featureTextField.text = ""
        featureTextField.placeholder = "(例)黄色パーカー"
    }
    
    /* アウトレット */
    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goodsNameTextField: UITextField!
    @IBOutlet weak var goodsConditionTextField: UITextField!
    @IBOutlet weak var goodsPriceTextField: UITextField!
    @IBOutlet weak var goodsPlaceTextField: UITextField!
    @IBOutlet weak var goodsCommentTextField: UITextField!
    @IBOutlet weak var goodsTimeTextField: UITextField!
    @IBOutlet weak var featureTextField: UITextField!
    
    
    
    /* アクション */
    //出品ボタン
    @IBAction func exhibitButtonTapped(_ sender: UIButton) {
        if(goodsNameTextField.text == "" || goodsConditionTextField.text == "" || goodsPriceTextField.text == "" || goodsPlaceTextField.text == "" || goodsTimeTextField.text == "" || featureTextField.text == ""){
            //アラートを表示する↓＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
            let alert1: UIAlertController = UIAlertController(title: "注意", message: "必須情報が入力されていません", preferredStyle: .actionSheet)
            let canselAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
                    print("キャンセル")
            }
            //アラートに設定を反映させる
            alert1.addAction(canselAction)
            //アラート画面を表示させる
            present(alert1, animated: true, completion: nil)
        }else{
            //アラートを表示する↓＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
            let alert2: UIAlertController = UIAlertController(title: "注意", message: "この商品を出品しますか？", preferredStyle: .actionSheet)
            let canselAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
                    print("キャンセル")
            }
            let okAction: UIAlertAction = UIAlertAction(title: "出品", style: .destructive) { (UIAlertAction) in
                    self.performSegue(withIdentifier: "ToPurchaseListView", sender: nil)
            }
            //アラートに設定を反映させる
            alert2.addAction(canselAction)
            alert2.addAction(okAction)
            //アラート画面を表示させる
            present(alert2, animated: true, completion: nil)
        }
    }
    
    //kintoneに情報投げる
    
    
    /* プロパティ */
    //登録する商品の情報
    var goods = GoodsInfo(image: UIImage(), name: "", condition: "", price: 0, place: "",time: "", feature: "", comment: "")
    
    
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
        if(textField.tag == 6){ //取引場所欄
            goods.time = textField.text!
        }
        if(textField.tag == 7){ //取引場所欄
            goods.feature = textField.text!
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
