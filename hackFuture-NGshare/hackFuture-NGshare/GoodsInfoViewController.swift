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
    
    var registerGoods = GoodsInfo.init() //登録する商品の情報

    var imageKeyTmp : String? // 撮った写真のキー
    
    var retentionFlag = 0 //保持しているデータがある時１
    
    var backBarButtonItem: UIBarButtonItem!     // 一覧画面に戻るボタン
    
    //デコーダとエンコーダ
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    
    /* アウトレット */
    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goodsNameTextField: UITextField!
    @IBOutlet weak var selectedConditionLabel: UILabel!
    @IBOutlet weak var goodsPriceTextField: UITextField!
    @IBOutlet weak var goodsPlaceTextField: UITextField!
    @IBOutlet weak var goodsCommentTextField: UITextField!
    @IBOutlet weak var goodsTimeTextField: UITextField!
    @IBOutlet weak var featureTextField: UITextField!
    @IBOutlet weak var selectConditionButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    
    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //タイトル変更
        navigationItem.title = "出品画面"
        
        //ナビゲーションバーの戻るボタンを消す
        self.navigationItem.hidesBackButton = true
        
        backBarButtonItem = UIBarButtonItem(title: "購入画面", style: .done, target: self, action: #selector(backBarButtonTapped(_:)))
        // バーボタンアイテムの追加
        self.navigationItem.leftBarButtonItems = [backBarButtonItem]
        
        //背景色の変更
        view.backgroundColor = UIColor(red: 178/255, green: 255/255, blue: 101/255, alpha: 1.0)
        
        self.goodsNameTextField.delegate = self
        self.goodsPriceTextField.delegate = self
        self.goodsPlaceTextField.delegate = self
        self.goodsCommentTextField.delegate = self
        self.goodsTimeTextField.delegate = self
        self.featureTextField.delegate = self
        
        //値段の入力時のキーボードに完了ボタンを追加
        let custombar = UIView(frame: CGRect(x:0, y:0,width:(UIScreen.main.bounds.size.width),height:40))
        custombar.backgroundColor = UIColor.groupTableViewBackground
        let commitBtn = UIButton(frame: CGRect(x:(UIScreen.main.bounds.size.width)-50,y:0,width:50,height:40))
        commitBtn.setTitle("完了", for: .normal)
        commitBtn.setTitleColor(UIColor.blue, for:.normal)
        commitBtn.addTarget(self, action:#selector(onClickCommitButton), for: .touchUpInside)
        custombar.addSubview(commitBtn)
        goodsPriceTextField.inputAccessoryView = custombar
        goodsPriceTextField.keyboardType = UIKeyboardType.numberPad
        goodsPriceTextField.delegate = self
        
        //文字列の初期化
        goodsNameTextField.text = ""
        goodsNameTextField.placeholder = "(例)モバイルバッテリー"
        selectedConditionLabel.text = ""
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
        
        
        if let data = UserDefaults.standard.data(forKey: imageKeyTmp!){
            goodsImage.image = UIImage(data: data)
        }
        
        //状態選択画面や確認画面から遷移してきた時。つまり値を保持している時
        if(retentionFlag == 1){
            
            if(registerGoods.name != "" && registerGoods.name != "noName"){
                goodsNameTextField.text = self.registerGoods.name
            }
            if(registerGoods.condition != "" && registerGoods.condition != "noCondition"){
                selectedConditionLabel.text = self.registerGoods.condition
                selectedConditionLabel.sizeToFit()
            }
            if(registerGoods.price != "" && registerGoods.price != "-1"){
                goodsPriceTextField.text = self.registerGoods.price
            }
            if(registerGoods.place != "" && registerGoods.place != "noPlace"){
                goodsPlaceTextField.text = self.registerGoods.place
            }
            if(registerGoods.time != "" && registerGoods.time != "noTime"){
                goodsTimeTextField.text = self.registerGoods.time
            }
            if(registerGoods.feature != "" && registerGoods.feature != "noFeature"){
                featureTextField.text = self.registerGoods.feature
            }
            if(registerGoods.comment != "" && registerGoods.comment != "noComment"){
                goodsCommentTextField.text = self.registerGoods.comment
            }
            
            retentionFlag = 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //状態選択画面へ
        if(segue.identifier == "toConSelectView"){
            let controller = segue.destination as! ConditionSelectViewController
            
            //入力中のデータを入れる
            controller.goodsTmp.name = self.registerGoods.name
            controller.goodsTmp.condition = self.registerGoods.condition
            controller.goodsTmp.price = self.registerGoods.price
            controller.goodsTmp.place = self.registerGoods.place
            controller.goodsTmp.time = self.registerGoods.time
            controller.goodsTmp.feature = self.registerGoods.feature
            controller.goodsTmp.comment = self.registerGoods.comment
        }
    }

    
    /* アクション */
    //出品ボタン
    @IBAction func exhibitButtonTapped(_ sender: UIButton) {
        if(registerGoods.name == "noName" || registerGoods.condition == "noCondition" || registerGoods.price == "-1" || registerGoods.place == "noPlace" || registerGoods.time == "noTime"){
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
            let alert2: UIAlertController = UIAlertController(title: "注意", message: "この商品を出品しますか？" + "\n-----------------------------------------------" + "\n【商品名】\n" + self.registerGoods.name + "\n\n【状態】\n" + self.registerGoods.condition + "\n\n【値段】\n" + self.registerGoods.price + "\n\n【取り引き場所】\n" + self.registerGoods.place + "\n\n【取引時間】\n" + self.registerGoods.time + "\n\n【出品者の特徴】\n" + self.registerGoods.feature + "\n\n【コメント】\n" + self.registerGoods.comment, preferredStyle: .actionSheet)
            let canselAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
                    print("キャンセル")
            }
            let okAction: UIAlertAction = UIAlertAction(title: "出品", style: .destructive) { (UIAlertAction) in
                //kintoneに登録
                
                
                var data: NSData = NSData()
                if let image = self.goodsImage.image {
                    data = image.jpegData(compressionQuality: 0.1)! as NSData
                }
                let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters) as String
                self.registerGoods.image = base64String
                
                //print("tmp_image\(tmp_image)")
                //print("\(self.registerGoods):self.registerGoods")
                addRecord(addedGoods: self.registerGoods)
                
                
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
            self.registerGoods.name = textField.text!
        }
        if(textField.tag == 3){ //値段欄
            self.registerGoods.price = textField.text!
        }
        if(textField.tag == 4){ //取引場所欄
            self.registerGoods.place = textField.text!
        }
        if(textField.tag == 5){ //取引時間欄
            self.registerGoods.time = textField.text!
        }
        if(textField.tag == 6){ //出品者の特徴欄
            self.registerGoods.feature = textField.text!
        }
        if(textField.tag == 7){ //コメント欄
            self.registerGoods.comment = textField.text!
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func onClickCommitButton (sender: UIButton) {
        if(goodsPriceTextField.isFirstResponder){
            goodsPriceTextField.resignFirstResponder()
        }
    }
    
    // "購入画面"ボタンが押された時の処理
    @objc func backBarButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "toPurchaseViewController", sender: nil)
    }
}

