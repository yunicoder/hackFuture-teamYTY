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
    
    let refreshCtl = UIRefreshControl()
    
    @IBOutlet weak var goodsImage: UIImageView!
    
    var goodsInfo = [GoodsInfo]() // 全部のデータ
    var filterGoodsInfo = [GoodsInfo]() //フィルター後のデータ(基本こっち)
    var searchGoodsInfo = [GoodsInfo]()
    
    // レイアウト用変数
    let margin:CGFloat = 0.5 // マージン
    let numOfColumn:CGFloat = 3 // 列の数
    
    
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
        refreshCtl.addTarget(self, action: Selector(("refreshTable")), for: UIControl.Event.valueChanged)
        self.goodsCollectionView.refreshControl = refreshCtl
        
        
        // kintoneからデータを取得する
        multiGetRecords(completionClosure: { (result:[GoodsInfo]) in
            self.goodsInfo = result
            // print("\(self.filterGoodsInfo):filterGoodsInfoFromLoad")
            self.filterGoodsInfo = self.goodsInfo
            self.goodsCollectionView.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        if(purchassFlag == 1){
            let alert: UIAlertController = UIAlertController(title: "購入エラー", message: "既に他の人が購入しています", preferredStyle:  UIAlertController.Style.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
            purchassFlag = 0
        }
        // kintoneからデータを取得する
        multiGetRecords(completionClosure: { (result:[GoodsInfo]) in
            self.filterGoodsInfo = result
             //print("\(self.filterGoodsInfo):filterGoodsInfoFromAppear")
            self.goodsInfo = result
            self.goodsCollectionView.reloadData()
        })
    }
    
    @objc func refreshTable() {
          // 更新処理
          // kintoneからデータを取得する
          multiGetRecords(completionClosure: { (result:[GoodsInfo]) in
              self.filterGoodsInfo = result
               //print("\(self.filterGoodsInfo):filterGoodsInfoFromAppear")
              self.goodsInfo = result
              self.goodsCollectionView.reloadData()
          })
          // クルクルを止める
        refreshCtl.endRefreshing()
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
        if let collectionImage = cell.contentView.viewWithTag(1) as? UIImageView {
            var picImage = PicDataToUIImage(picData: filterGoodsInfo[indexPath.row].image) // base64からUIImageに変換
            let cellWidth:CGFloat = goodsCollectionView.bounds.size.width / numOfColumn -  margin * (numOfColumn - 1)// セルの縦横の大きさを計算
            let reSize = CGSize(width: cellWidth, height: cellWidth) // セルの縦横の大きさ
            picImage = picImage.reSizeImage(reSize: reSize) // 画像の大きさをセルの縦横に合わせる
            collectionImage.image = picImage // 画像を表示
        }
        
        // cellの中にあるLabelに価格を代入する
        if let priceLabel = cell.contentView.viewWithTag(2) as? UILabel {
            priceLabel.text = "¥ " + filterGoodsInfo[indexPath.row].price + " "
        }
        
        // cell.backgroundColor = .red  // セルの色をなんとなく赤に
        return cell
    }
    
    
    // collectionViewの委譲ではなくレイアウトで
    func LayoutInit(collectionView: UICollectionView){
        let layout = UICollectionViewFlowLayout() // 今回のセルのレイアウト
        let cellWidth:CGFloat = goodsCollectionView.bounds.size.width / numOfColumn -  margin * (numOfColumn - 1)// セルの縦横の大きさを計算
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth) // セルの大きさを設定
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

