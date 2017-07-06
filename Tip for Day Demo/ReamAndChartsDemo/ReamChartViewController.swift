//
//  ReamChartViewController.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/7/5.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ReamChartViewController: UIViewController {
    
    @IBOutlet weak var tfValue: UITextField!

    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeAllData()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedAddButton(_ sender: UIButton) {
        if let value = tfValue.text, value != "" {
            let v = VisitorCount()
            v.count = (value as NSString).integerValue
            v.saveToDatabase()
            tfValue.text = ""
            updateCharData()
        }
    }
}

extension ReamChartViewController{
    fileprivate func updateCharData(){
        // 从Realm数据库中获取数据
        guard let visitorCount = getVisitorFromDatabase() else {return}
        // 定义数组
        var dataEntries : [BarChartDataEntry] = []
        // 遍历从Realm中获取的结果
        for i in 0 ..< visitorCount.count {
            // 创建数据节点
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(visitorCount[i].count))
            // 添加到数组中
            dataEntries.append(dataEntry)
        }
        // 创建数据集
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor count")
        // 
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
   
    }
    // 获取数据库中的结果
    fileprivate func getVisitorFromDatabase() -> Results<VisitorCount>?{
        
        guard let realm = try? Realm() else {return nil}
       
        return realm.objects(VisitorCount.self)
    }
    // 删除数据库中的数据
    fileprivate func removeAllData(){
           guard let realm = try? Realm() else {return}
    
        // 从Realm数据库中获取数据
        guard let visitorCount = getVisitorFromDatabase() else {return}
       try? realm.write {
            realm.delete(visitorCount)
        }
    }
}
