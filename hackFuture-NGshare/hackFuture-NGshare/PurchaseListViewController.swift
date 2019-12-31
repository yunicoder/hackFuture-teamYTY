//
//  ViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit

//商品状態の構造体
struct GoodsInfo : Codable{
    var image : String //商品の画像名。保存したキー
    var name : String //商品の名前
    var condition : String //商品の状態
    var price : Int //商品の値段
    var place : String //やりとり場所
    var time : String //やりとり時間
    var feature : String //自分の特徴
    var comment : String //コメント
}


class PurchaseListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var nameSearch: UISearchBar!
    @IBOutlet weak var goodsCollectionView: UICollectionView! // 商品のコレクションビュー
    
    @IBOutlet weak var goodsImage: UIImageView!
    
    //var goodsInfo = [GoodsInfo]() // 全部のデータ
    var filterGoodsInfo = [GoodsInfo]() //フィルター後のデータ(基本こっち)
    
    
    /* プロパティ */
    var goods : [GoodsInfo] = []
    var firstFlag = 1
    var addFlag = 0
    
    //デコーダとエンコーダ
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    //登録画面からデータを受け取るため
    var imageTmp : String?
    var nameTmp : String?
    var conditionTmp : String?
    var priceTmp : Int?
    var placeTmp : String?
    var timeTmp : String?
    var featureTmp : String?
    var commentTmp : String?
    
    
    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "出品リスト"
        self.navigationItem.hidesBackButton = true //戻るボタンを消す
        
        goodsCollectionView.delegate = self    // サイズやマージンなどレイアウトに関する処理の委譲
        goodsCollectionView.dataSource = self  // 要素の数やセル、クラスなどデータの元となる処理の委譲
        
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // マージン
        goodsCollectionView.collectionViewLayout = layout
        
<<<<<<< HEAD
        // kintoneからデータを取得する
        multiGetRecords(completionClosure: { (result:[GoodsInfo]) in
            self.filterGoodsInfo = result
            print("\(self.filterGoodsInfo):filterGoodsInfo")
            self.goodsCollectionView.reloadData()
        })
=======
        //起動時に一度だけやる処理
        if(firstFlag == 1){
            //本体に保存されている内容を読み込み
            if((UserDefaults.standard.array(forKey: "GoodsInfo")) != nil){
                var loadInfoData:[String] = UserDefaults.standard.array(forKey: "GoodsInfo") as! [String]
                for value in 0...(loadInfoData.count-1){
                    var loadData:GoodsInfo? = try? decoder.decode(GoodsInfo.self, from: loadInfoData[value].data(using: .utf8)!)
                    goods.append(loadData!)
                }
            }
            firstFlag = 0
        }
        
        //追加フラグが１なら。すなわち、登録画面で新しく登録されたら
        if(addFlag == 1){
            var new = GoodsInfo(image: imageTmp!, name: nameTmp!, condition: conditionTmp!, price: priceTmp!, place: placeTmp!, time: timeTmp!, feature: featureTmp!, comment: commentTmp!)
            goods.append(new)
            
            addFlag = 0
         
            //UserDefaultsの内容全消去
            UserDefaults.standard.removeObject(forKey: "GoodsInfo")
            //本体に保存
            if(goods.isEmpty == false){ //itemsが空なら保存しない
                var setInfoList: [String] = []
                for value in 0...(goods.count-1){
                    var data = try? encoder.encode(goods[value]) //データ型に変換
                    setInfoList.append(String(data:data!, encoding: .utf8)!) //String型に変換
                    UserDefaults.standard.set(setInfoList, forKey: "GoodsInfo")
                }
            }
        }
        
       
>>>>>>> c138f870c3ffebcddb03ff5f2d22a4e0e1b68151
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // kintoneからデータを取得する
        multiGetRecords(completionClosure: { (result:[GoodsInfo]) in
            self.filterGoodsInfo = result
            print("\(self.filterGoodsInfo):filterGoodsInfo")
            self.goodsCollectionView.reloadData()
        })
        goodsCollectionView.reloadData() // データをリロードする
    }
    
    //リターンキーが押された時
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameSearch.resignFirstResponder() //改行
        let searchname = nameSearch.text! // 検索された名前
        
        return true
    }
    
    /*---collectionViewの委譲設定 開始---*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
<<<<<<< HEAD
        return filterGoodsInfo.count // 表示するセルの数
=======
        return goods.count // 表示するセルの数
        //return 10
>>>>>>> c138f870c3ffebcddb03ff5f2d22a4e0e1b68151
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = goodsCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先にStoryboad内でidentifierを指定しておく)
        if let collectionImage = cell.contentView.viewWithTag(1) as? UIImageView {
            // cellの中にあるcollectionImageに画像を代入する
            collectionImage.image = UIImage(data: UserDefaults.standard.data(forKey: goods[indexPath.row].image)!)
        }
        if let nameLabel = cell.contentView.viewWithTag(2) as? UILabel {
            // cellの中にあるLabelに商品名を代入する
            nameLabel.text = filterGoodsInfo[indexPath.row].name
        }
        cell.backgroundColor = .red  // セルの色をなんとなく赤に
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // 全体レイアウトの設定
        return CGSize(width: 100, height: 100)
    }
    
    /*---collectionViewの設定の委譲など 終わり---*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // セグエによる画面遷移が行われる前に呼ばれるメソッド
        if (segue.identifier == "segue") {
            let nextVC: PurchaseViewController = (segue.destination as? PurchaseViewController)!
            let selectedRow = goodsCollectionView.indexPathsForSelectedItems! // 選ばれた
            nextVC.recieveGoodsInfo = self.filterGoodsInfo[selectedRow[0].row]
        }
    }


}

