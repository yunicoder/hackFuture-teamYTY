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
    
    var goodsInfo = [GoodsInfo]() // 全部のデータ
    var filterGoodsInfo = [GoodsInfo]() //フィルター後のデータ
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        goodsCollectionView.delegate = self    // サイズやマージンなどレイアウトに関する処理の委譲
        goodsCollectionView.dataSource = self  // 要素の数やセル、クラスなどデータの元となる処理の委譲
        //layoutInit(collectionView: goodsCollectionView) // レイアウトの設定
        
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // マージン
        goodsCollectionView.collectionViewLayout = layout
    }
    
    //リターンキーが押された時
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameSearch.resignFirstResponder() //改行
        let searchname = nameSearch.text! // 検索された名前
        
        return true
    }
    
    /*---collectionViewの委譲設定 開始---*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return filterGoodsInfo.count // 表示するセルの数
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = goodsCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先にStoryboad内でidentifierを指定しておく)
        if let collectionImage = cell.contentView.viewWithTag(1) as? UIImageView {
            // cellの中にあるcollectionImageに画像を代入する
            //collectionImage.image = filterGoodsInfo[indexPath.row].image
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
            let nextVC: GoodsInfoViewController = (segue.destination as? GoodsInfoViewController)!
            let selectedRow = goodsCollectionView.indexPathsForSelectedItems! // 選ばれた
            
            //nextVC.phasset = photos[selectedRow[0].row]  // NextViewController のselectedImgに選択された画像を設定する
            //print("***\(nextVC.phasset)***")
        }
    }


}

