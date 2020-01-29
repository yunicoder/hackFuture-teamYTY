//
//  ViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit

class PurchaseListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate  {
    @IBOutlet weak var nameSearch: UISearchBar!
    @IBOutlet weak var goodsCollectionView: UICollectionView! // 商品のコレクションビュー
    
    @IBOutlet weak var goodsImage: UIImageView!
    
    var goodsInfo = [GoodsInfo]() // 全部のデータ
    var filterGoodsInfo = [GoodsInfo]() //フィルター後のデータ(基本こっち)
    var searchGoodsInfo = [GoodsInfo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameSearch.delegate = self
        nameSearch.placeholder = "商品名の検索"
        nameSearch.showsCancelButton = true
        navigationItem.title = "出品リスト"
        self.navigationItem.hidesBackButton = true //戻るボタンを消す
        
        goodsCollectionView.delegate = self    // サイズやマージンなどレイアウトに関する処理の委譲
        goodsCollectionView.dataSource = self  // 要素の数やセル、クラスなどデータの元となる処理の委譲
        
        LayoutInit(collectionView: goodsCollectionView) // セルの大きさなどのレイアウトを設定
        
        // kintoneからデータを取得する
        multiGetRecords(completionClosure: { (result:[GoodsInfo]) in
            self.goodsInfo = result
            // print("\(self.filterGoodsInfo):filterGoodsInfoFromLoad")
            self.filterGoodsInfo = self.goodsInfo
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
        print("\(#function)")
        nameSearch.resignFirstResponder() //改行
        let searchname = nameSearch.text! // 検索された名前
        
        return true
    }
    
    //キャンセルボタン押下時の呼び出しメソッド
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("\(#function)")
        // キャンセルされた場合、検索は行わない。
        searchBar.text = ""
        self.view.endEditing(true)
        filterGoodsInfo = goodsInfo
        goodsCollectionView.reloadData() // データをリロードする
    }
    
    //検索ボタン押下時の呼び出しメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("\(#function)")
        nameSearch.endEditing(true)
        
        //検索結果配列を空にする。
        searchGoodsInfo.removeAll()
        
        if(nameSearch.text == "") {
            //検索文字列が空の場合はすべてを表示する。
            searchGoodsInfo = filterGoodsInfo
        } else {
            //検索文字列を含むデータを検索結果配列に追加する。
            for (i,_) in filterGoodsInfo.enumerated() {
                if (filterGoodsInfo[i].name.contains(nameSearch.text!)){
                    searchGoodsInfo.append(filterGoodsInfo[i])
                }
            }
        }
        
        //テーブルを再読み込みする。
        filterGoodsInfo = searchGoodsInfo
        goodsCollectionView.reloadData()
    }
 
    
    /*---collectionViewの委譲設定 開始---*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterGoodsInfo.count // 表示するセルの数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = goodsCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先にStoryboad内でidentifierを指定しておく)
        
        // cellの中にあるcollectionImageに画像を代入する
        if var collectionImage = cell.contentView.viewWithTag(1) as? UIImageView {
            var picImage = PicDataToUIImage(picData: filterGoodsInfo[indexPath.row].image)
            var picImageView = UIImageView(image:picImage)
            
            
            let width = collectionView.bounds.size.width / 3.0 -  0.5 * (3.0 - 1)
            picImageView.frame = CGRect(x:0, y:0, width:width, height:width)
            
            collectionImage = picImageView
        }
        
        // cellの中にあるLabelに商品名を代入する
        if let nameLabel = cell.contentView.viewWithTag(2) as? UILabel {
            nameLabel.text = filterGoodsInfo[indexPath.row].name
        }
        
        cell.backgroundColor = .red  // セルの色をなんとなく赤に
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

