//
//  GoodsInfoViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit



class GoodsInfoViewController: UIViewController, UITextFieldDelegate {
    
    /* プロパティ */
    //登録する商品の情報
    var imageTmp : UIImage?
    var nameTmp : String?
    var conditionTmp : String?
    var priceTmp : String?
    var placeTmp : String?
    var timeTmp : String?
    var featureTmp : String?
    var commentTmp : String?
    var imageKeyTmp : String?
    
    //デコーダとエンコーダ
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    
    /* アウトレット */
    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goodsNameTextField: UITextField!
    @IBOutlet weak var goodsConditionTextField: UITextField!
    @IBOutlet weak var goodsPriceTextField: UITextField!
    @IBOutlet weak var goodsPlaceTextField: UITextField!
    @IBOutlet weak var goodsCommentTextField: UITextField!
    @IBOutlet weak var goodsTimeTextField: UITextField!
    @IBOutlet weak var featureTextField: UITextField!
    
    
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
        
        
        goodsImage.image = UIImage(data: UserDefaults.standard.data(forKey: "takenImage")!)
    }
    
    //セグエによる画面遷移が行われる直前
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let controller = segue.destination as! PurchaseListViewController
        //追加する人の情報を渡す
        //controller.imageTmp = self.imageKeyTmp
        //controller.nameTmp = self.nameTmp
        //controller.conditionTmp = self.conditionTmp
        //controller.priceTmp = self.priceTmp
        //controller.placeTmp = self.placeTmp
        //controller.timeTmp = self.timeTmp
        //controller.fetureTmp = self.featureTmp
        //controller.commentTmp = self.commentTmp
    }
    
    
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
                /*
                    //kintoneに登録
                self.imageTmp = self.goodsImage.image!.jpegData(compressionQuality: 1);
                addRecord(image: self.imageTmp!, name: self.nameTmp!, condition: self.conditionTmp!, price: self.priceTmp!, place: self.placeTmp!, coment: self.commentTmp!, future: self.featureTmp!)
                 */
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
    
    
    /* メソッド */
    //リターンキーが押された時
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //改行
        if(textField.tag == 1){ //名前欄
            nameTmp = textField.text!
        }
        if(textField.tag == 2){ //状態欄
            conditionTmp = textField.text!
        }
        if(textField.tag == 3){ //値段欄
            priceTmp = textField.text!
        }
        if(textField.tag == 4){ //取引場所欄
            placeTmp = textField.text!
        }
        if(textField.tag == 5){ //取引場所欄
            commentTmp = textField.text!
        }
        if(textField.tag == 6){ //取引場所欄
            timeTmp = textField.text!
        }
        if(textField.tag == 7){ //取引場所欄
            featureTmp = textField.text!
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
