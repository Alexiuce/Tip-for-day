//
//  ReamChartViewController.swift
//  Tip for Day Demo
//
//  Created by alexiuce  on 2017/7/5.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import UIKit
import Charts

class ReamChartViewController: UIViewController {
    
    @IBOutlet weak var tfValue: UITextField!

    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedAddButton(_ sender: UIButton) {
        if let value = tfValue.text, value != "" {
            let v = VisitorCount()
            v.count = (value as NSString).integerValue
            v.saveToDatabase()
            tfValue.text = ""
        }
    }

}
