//
//  ViewController.swift
//  BaiduMap Demo
//
//  Created by alexiuce  on 2017/6/23.
//  Copyright © 2017年 com.Alexiuce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var _locationService: BMKLocationService!
    var _mapView : BMKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 定位服务对象
        _locationService = BMKLocationService()
        // 设置最小更新距离（Double类型）
        _locationService.distanceFilter = 10;
        // 设置定位代理
        _locationService.delegate = self
        // 开启定位
        _locationService.startUserLocationService()
        // 地图视图
       _mapView = BMKMapView(frame: view.bounds)
        // 设置定位模式
       _mapView?.userTrackingMode = BMKUserTrackingModeHeading
        // 显示用户位置（小蓝点）:普通定位模式下，圆形小蓝点没有方向箭头
       _mapView?.showsUserLocation = true
        // 设置地图显示放大的级别（3～21）： 值越大，放大越明显
       _mapView?.zoomLevel = 18
       view.addSubview(_mapView!)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _mapView?.viewWillAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _locationService.delegate = nil;
        _mapView?.viewWillDisappear()
    }
}
// MARK: BMKLocationServiceDelegate

extension ViewController : BMKLocationServiceDelegate{
  
    func didUpdate(_ userLocation: BMKUserLocation!) {
        print(userLocation.isUpdating ? "updating" : "no uping")
        // 更新地图数据：这里并不会刷新地图UI
         _mapView?.updateLocationData(userLocation)
        // 中心点坐标 ： 设置后，地图会显示坐标所在的城市地图
        _mapView?.centerCoordinate = userLocation.location.coordinate
        // 设置地图显示的放大级数(3~21)
       
        
    }
}
