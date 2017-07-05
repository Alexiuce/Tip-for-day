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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
