//
//  ConditionSelectViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2020/01/27.
//  Copyright © 2020 ATSUSHI YANO. All rights reserved.
//

import UIKit


class ConditionSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    /* アウトレット */
    @IBOutlet weak var tableView: UITableView!
    
    
    /* プロパティ */
    //入力途中のデータを入れる
    var goodsTmp = GoodsInfo.init()
    
    //表示する状態の配列
    var conditions : [String] = ["AA (新品・未使用)","A    (未使用に近い・開封したが未使用)","AB (目立った傷や汚れなし・少量使用済み)","B    (やや傷や汚れあり・3分の1ほど使用済み)","C    (傷や汚れあり・半分ほど使用済み)","D    (全体的に状態が悪い・3分の2以上使用済み)"]
    
    
    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //セルがタップされたら
        if(segue.identifier == "toGoodsInfoView"){
            //どのセルをタップしたかを調べる
            //indexPathForSelectedRowは最後に選択したセルのIndexPathインスタンスを提供する
            if let selectedRow = tableView.indexPathForSelectedRow {
                //destinationは遷移先のビューコントローラーのインスタンスを提供。型はUIViewControllerクラスになっているので、ダウンキャストしている。
                let controller = segue.destination as! GoodsInfoViewController
                
                //入力途中のデータと選んだ状態を入れる
                controller.registerGoods.name = self.goodsTmp.name
                controller.registerGoods.condition = self.conditions[selectedRow.row]
                    controller.registerGoods.price =  self.goodsTmp.price
                controller.registerGoods.place = self.goodsTmp.place
                controller.registerGoods.time = self.goodsTmp.time
                controller.registerGoods.feature = self.goodsTmp.feature
                controller.registerGoods.comment = self.goodsTmp.comment
                
                controller.retentionFlag = 1
            }
        }
    }
    
    
    /* メソッド */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conditions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "conditionNameCell")
        let condition = conditions[indexPath.row]
        cell.textLabel?.text = condition
        
        return cell
    }
}
