//
//  ChatViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "取引画面"
    }
    
    
    /* アウトレット */
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var placeText: UILabel!
    @IBOutlet weak var goodsImagetext: UIImageView!
    @IBOutlet weak var goodsNameText: UILabel!
    @IBOutlet weak var goodsConditionText: UILabel!
    @IBOutlet weak var goodsPriceText: UILabel!
    
    
    
    /* アクション */
    //受け取り完了ボタンを押したら
    @IBAction func completeButtonTapped(_ sender: UIButton) {
    }
}
