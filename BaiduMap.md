### BaiduMap Target
在Swift4.0中集成百度图  

* 准备工作： 
  * 注册百度开发者，并创建应用，获取密钥（AK）
  * 下载SKD（可根据具体情况下载需要的部分）

* 集成 
  参考百度官方指导   
  [基于Swift集成](http://lbsyun.baidu.com/index.php?title=iossdk/guide/swift)  
  
  **注意事项（坑）**  
  * #import < BaiduMapAPI_Map/BMKMapView.h>这里的文件名前多了一个空格，需去掉，否则编译报文件找不到
  * 建议集成时，使用cocoapod方式
  * 在项目中添加一个新Objective-C文件，会自动生成桥接文件，然后再将这个OC文件delete，这样就不需要再手动配置桥接文件路径
  * 应用的info.plist 中，需要设置**Bundle display name**，否则Baidu地图注册时报错
  * 打包发布时，需要设置**Building Settings**的Enable Bitcode 为No，否则编译不通过
* 显示地图
   
   ```swift
    var _mapView : BMKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       _mapView = BMKMapView(frame: view.bounds)
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
        _mapView?.viewWillDisappear()
    }
    
   ``` 
  
* 定位

  ```swift
    // 定位服务对象
        _locationService = BMKLocationService()
         // 设置最小更新距离（Double类型）默认值为kCLDistanceFilterNone（位置发生任意改变都会更新）
        _locationService.distanceFilter = 10;
        // 设置定位代理
        _locationService.delegate = self
        // 开启定位
        _locationService.startUserLocationService()
        // 设置定位模式
       _mapView?.userTrackingMode = BMKUserTrackingModeHeading
       // 显示用户位置（小蓝点）:普通定位模式下，圆形小蓝点没有方向箭头
       _mapView?.showsUserLocation = true
        
    // 在代理方法中，更新地图中心坐标    
    func didUpdate(_ userLocation: BMKUserLocation!) {
        // 更新地图数据：这里并不会刷新地图UI
         _mapView?.updateLocationData(userLocation)
        // 中心点坐标 ： 设置后，地图会显示坐标所在的城市地图
        _mapView?.centerCoordinate = userLocation.location.coordinate  
    }
  ``` 
    
* 地图标注(两个步骤)
 > **1.创建标注数据并添加到BMKMapView中**  
 
 ```swift
  fileprivate func addCustomAnnotation(){
      let anno = BMKPointAnnotation()
        anno.coordinate.latitude = 30.897
        anno.coordinate.longitude = 120.532
        _mapView?.addAnnotation(anno)
    }
 ```
 > **2.实现BMKMapViewDelegate的方法**
 
 ```swift
 // 返回标注视图
 func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! 
 
 
 
 ```  
   
* 错误码参考
  [LBS控制服务返回码定义及常见问题汇总](http://bbs.lbsyun.baidu.com/forum.php?mod=viewthread&tid=42223&page=1&extra=#pid93042)

  
   
