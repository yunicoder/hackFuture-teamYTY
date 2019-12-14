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
    
    var goodsImageUrl = ["https://www.pokemon.co.jp/ex/sword_shield/assets/pokemon/thumb_pokemon_190605_03.png","https://realsound.jp/wp-content/uploads/2019/08/20190808-pokemon00-633x633.jpg","https://www.inside-games.jp/imgs/zoom/910737.jpg","https://contents.oricon.co.jp/upimg/news/20190228/2130393_201902280585905001551323314c.jpg","https://www.pokemon.co.jp/ex/sword_shield/assets/pokemon/thumb_pokemon_190605_02.png","http://www.billboard-japan.com/scale/news/00000040/40566/800x_image.jpg","https://dengekionline.com/images/a1jL/pcAC/bAwD/kAfD/RDDEV6uxzuArBD6vxauLROrmLN98HWrT4AGQX1tANkwMUwKVkHt1mcRREcjCDUOVDhObkJHyNbDbbC1V.jpg","https://www.pokemon.co.jp/ex/sword_shield/assets/pokemon/thumb_pokemon_190605_03.png","https://realsound.jp/wp-content/uploads/2019/08/20190808-pokemon00-633x633.jpg","https://www.inside-games.jp/imgs/zoom/910737.jpg","https://contents.oricon.co.jp/upimg/news/20190228/2130393_201902280585905001551323314c.jpg","https://www.pokemon.co.jp/ex/sword_shield/assets/pokemon/thumb_pokemon_190605_02.png","http://www.billboard-japan.com/scale/news/00000040/40566/800x_image.jpg","https://dengekionline.com/images/a1jL/pcAC/bAwD/kAfD/RDDEV6uxzuArBD6vxauLROrmLN98HWrT4AGQX1tANkwMUwKVkHt1mcRREcjCDUOVDhObkJHyNbDbbC1V.jpg","https://www.pokemon.co.jp/ex/sword_shield/assets/pokemon/thumb_pokemon_190605_03.png","https://realsound.jp/wp-content/uploads/2019/08/20190808-pokemon00-633x633.jpg","https://www.inside-games.jp/imgs/zoom/910737.jpg","https://contents.oricon.co.jp/upimg/news/20190228/2130393_201902280585905001551323314c.jpg","https://www.pokemon.co.jp/ex/sword_shield/assets/pokemon/thumb_pokemon_190605_02.png","http://www.billboard-japan.com/scale/news/00000040/40566/800x_image.jpg","https://dengekionline.com/images/a1jL/pcAC/bAwD/kAfD/RDDEV6uxzuArBD6vxauLROrmLN98HWrT4AGQX1tANkwMUwKVkHt1mcRREcjCDUOVDhObkJHyNbDbbC1V.jpg"] // 写真のURL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //goodsCollectionView.delegate = self    // サイズやマージンなどレイアウトに関する処理の委譲
        //goodsCollectionView.dataSource = self  // 要素の数やセル、クラスなどデータの元となる処理の委譲
        //layoutInit(collectionView: goodsCollectionView) // レイアウトの設定
        
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // マージン
        //goodsCollectionView.collectionViewLayout = layout
    }
    
    // URLから画像を生成する関数
       func getImageByUrl(url: String) -> UIImage{
           let url = URL(string: url)
           do {
               let data = try Data(contentsOf: url!)
               return UIImage(data: data)!
           } catch let err {
               print("Error : \(err.localizedDescription)")
           }
           return UIImage()
       }
    
    /*---collectionViewの委譲設定 開始---*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsImageUrl.count // 表示するセルの数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = goodsCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先にStoryboad内でidentifierを指定しておく)
        if let collectionImage = cell.contentView.viewWithTag(1) as? UIImageView {
            // cellの中にあるcollectionImageに画像を代入する
            collectionImage.image = getImageByUrl(url: self.goodsImageUrl[indexPath.row])
        }
        //cell.backgroundColor = .red  // セルの色をなんとなく赤に
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // 全体レイアウトの設定
        return CGSize(width: 100, height: 100)
    }
    /*---collectionViewの設定の委譲など 終わり---*/
    


}

