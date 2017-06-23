//
//  ViewController.swift
//  BaiduMap Demo
//
//  Created by alexiuce  on 2017/6/23.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var _mapView : BMKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       _mapView = BMKMapView(frame: view.bounds)
       view.addSubview(_mapView!)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _mapView?.viewWillAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView?.viewWillDisappear()
    }
}

