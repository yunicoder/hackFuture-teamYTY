//
//  ViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit

class PurchaseListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var nameSearch: UISearchBar!
    @IBOutlet weak var goodsCollectionView: UICollectionView! // 商品のコレクションビュー
    
    @IBOutlet weak var goodsImage: UIImageView!
    
    //var goodsInfo = [GoodsInfo]() // 全部のデータ
    var filterGoodsInfo = [GoodsInfo]() //フィルター後のデータ(基本こっち)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "出品リスト"
        self.navigationItem.hidesBackButton = true //戻るボタンを消す
        
        goodsCollectionView.delegate = self    // サイズやマージンなどレイアウトに関する処理の委譲
        goodsCollectionView.dataSource = self  // 要素の数やセル、クラスなどデータの元となる処理の委譲
        
        LayoutInit(collectionView: goodsCollectionView) // セルの大きさなどのレイアウトを設定
        
        // kintoneからデータを取得する
        multiGetRecords(completionClosure: { (result:[GoodsInfo]) in
            self.filterGoodsInfo = result
            // print("\(self.filterGoodsInfo):filterGoodsInfoFromLoad")
            self.goodsCollectionView.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // kintoneからデータを取得する
        multiGetRecords(completionClosure: { (result:[GoodsInfo]) in
            self.filterGoodsInfo = result
             //print("\(self.filterGoodsInfo):filterGoodsInfoFromAppear")
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
        return filterGoodsInfo.count // 表示するセルの数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = goodsCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先にStoryboad内でidentifierを指定しておく)
        if let collectionImage = cell.contentView.viewWithTag(1) as? UIImageView {
            // cellの中にあるcollectionImageに画像を代入する
            if let decodedData = Data(base64Encoded: filterGoodsInfo[indexPath.row].image , options: Data.Base64DecodingOptions.ignoreUnknownCharacters){ // based64の文字列をdata型に変換してそれがnilではない時、つまり写真データがある時
                let decodedImage = UIImage(data: decodedData as Data) // dataをUIImageに変換
                collectionImage.image = decodedImage // 写真を表示
            }
            else{ // 写真データがない、もしくは変換できない時
                collectionImage.image = UIImage(named: "noImage") // noImageと表示
            }
        }
        if let nameLabel = cell.contentView.viewWithTag(2) as? UILabel {
            // cellの中にあるLabelに商品名を代入する
            nameLabel.text = filterGoodsInfo[indexPath.row].name
        }
        // cell.backgroundColor = .red  // セルの色をなんとなく赤に
        return cell
    }
    
    
    // collectionViewの委譲ではなくレイアウトで
    func LayoutInit(collectionView: UICollectionView){
        let margin:CGFloat = 0.5 // マージン
        let numOfColumn:CGFloat = 3 // 列の数
        let layout = UICollectionViewFlowLayout() // 今回のセルのレイアウト
        let width = collectionView.bounds.size.width / numOfColumn -  margin * (numOfColumn - 1)// 縦横の大きさを計算
        
        layout.itemSize = CGSize(width: width, height: width) // セルの大きさを設定
        layout.minimumInteritemSpacing = margin // セル同士の間隔
        
        collectionView.collectionViewLayout = layout
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

