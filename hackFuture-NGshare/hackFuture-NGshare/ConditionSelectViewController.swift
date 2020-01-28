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
    var goodsTmp : GoodsInfo?
    
    //表示する状態の配列
    var conditions : [String] = ["AA (新品・未使用)","A    (未使用に近い)","AB (目立った傷や汚れなし)","B    (やや傷や汚れあり)","C    (傷や汚れあり)","D    (全体的に状態が悪い)"]
    
    
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
    
    
    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
}
